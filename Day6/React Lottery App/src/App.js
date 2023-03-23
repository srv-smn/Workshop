import React ,{Component} from 'react';
import logo from './logo.svg';
import './App.css';
import web3 from './web3';
import lottery from './lottery';
import { Segment,Header, Card, Form, Container, Button } from 'semantic-ui-react' ;


class App extends Component {
  state ={
    manager:'',
    players:[],
    balance: '',
    value:'',
    message:''
  };

  async componentDidMount(){
    const manager = await lottery.methods.manager().call();
    const players = await lottery.methods.getPlayers().call();
    const balance = await web3.eth.getBalance(lottery.options.address)
    this.setState({manager, players, balance});

  }
// header
HeaderExampleFloating(){
  return (
     <Segment>
     <Header as ='h2' color = 'blue' textAlign = 'center'>
     LOTTERY CONTRACT
     </Header>
     </Segment>
  );
}

renderCards(){
  const items = [
  {
    header: this.state.manager,
    description:
      'Owner/creator of the contract',
    meta: 'MANAGER',
    color: 'red',
    centered: true,
    style:{overflowWrap: 'break-word'},
  },
  {
    header: '0.001 ETH',
    description:
      'Minimum contribution to participate in the lottery',
    meta: 'Minimum Contribution',
    color: 'blue',
    centered: true,
    style:{overflowWrap: 'break-word'},
  },
  {
    header: this.state.players.length,
    description:
      'Tolal number of players in the Lottery',
    meta: 'total participants',
    color: 'yellow',
    centered: true,
    style:{overflowWrap: 'break-word'},
  },
  {
    header: web3.utils.fromWei(this.state.balance,'ether'),
    description:
      'Total money in the lottery',
    meta: 'Winning amount',
    color: 'blue',
    centered: true,
    style:{overflowWrap: 'break-word'},
  },
]
return <Card.Group items={items} /> ;

}
onSubmit = async event =>{
  event.preventDefault();
  const accounts = await web3.eth.getAccounts();
  this.setState({message: 'Waiting for transaction success ...'});
  await lottery.methods.enter().send({
    from:accounts[0],
    value: web3.utils.toWei(this.state.value,'ether')
  });
  this.setState({message: 'You have entered in the contract'});
  window.location.reload(false);

};

onClick = async() =>{
  const accounts = await web3.eth.getAccounts();
  this.setState({message: 'waiting for transaction success ...'});
  await lottery.methods.pickWinner().send({
    from: accounts[0]
  });
  this.setState({message: 'Winner has been picked...'});
  window.location.reload(false);
}

onConnect = async() =>{
  try {
    await window.ethereum.request({ method: 'eth_requestAccounts' });
    console.log('Connected to Metamask wallet');
    // additional code to handle connected wallet here
  } catch (error) {
    console.log(error);
  }
}






  render(){
  return (
    <div className="App">
  <p>  {this.HeaderExampleFloating()} </p>
    <p>  {this.renderCards()} </p>
      <p>
        
      <Container style = {{marginTop: '30px'}}>
      <Card centered = {true} color = 'Yellow' fluid = {true}>
      <p><h2 align = 'center' color = 'blue'> Connect your wallet </h2></p>
      <Button type ='submit' positive = {true} fluid ={true} onClick = {this.onConnect}>Connect wallet
      </Button>
      <h5>{this.state.message}</h5>
      </Card>
      </Container>

      <Container style = {{marginTop : '30px'}}>
      <Card centered = {true} color = 'yellow' fluid = {true}>
      <Form onSubmit = {this.onSubmit} size = 'big'>
      <p> <h2 align  = 'center' color = 'blue'> Want to try your luck ? </h2></p>
      <Form.Input placeholder = 'Amount in ether'
      name =  'name'
      value = {this.state.value}
      onChange = {event => this.setState({value: event.target.value})}
      />
      <Button type ='submit' positive = {true} fluid = {true}> Submit </Button>
      </Form>
      </Card>
      </Container>
      </p>
      <Container style = {{marginTop: '30px'}}>
      <Card centered = {true} color = 'Yellow' fluid = {true}>
      <p><h2 align = 'center' color = 'blue'> Ready to pick a winner ? </h2></p>
      <Button type ='submit' positive = {true} fluid ={true} onClick = {this.onClick}>Pick a Winner!
      </Button>
      <h5>{this.state.message}</h5>
      </Card>
      </Container>

    </div>
  );
}
}

export default App;
