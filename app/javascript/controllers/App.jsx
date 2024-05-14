import { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import HomePage from './HomePage';
import LoginPage from './LoginPage';
import AfterLoginPage from './AfterLoginPage';

export const App = () => {
  const [count, setCount] = useState(0)

  useEffect(() => {
    console.log(`count is: ${count}`)
  }, [count])

  return (
    <Router>
      <Switch>
        <Route path="/login">
          <LoginPage />
        </Route>
        <Route path="/after_login">
          <AfterLoginPage />
        </Route>
        <Route path="/">
          <div>
            <p>Hello Bun!</p>
            <p>
              <button type='button' onClick={() => setCount((count) => count + 1)}>
                count is: {count}
              </button>
            </p>
          </div>
        </Route>
      </Switch>
    </Router>
  )
}