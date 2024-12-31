/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import {
  Colors,
} from 'react-native/Libraries/NewAppScreen';
import type {PropsWithChildren} from 'react';
import AVFoundationScreen from './pages/AVFoundation/AVFoundationScreen';
import MLKitScreen from './pages/MLKit/MLKitScreen';
import VisionKitScreen from './pages/VisionKit/VisionKitScreen';
import { SafeAreaView, useColorScheme } from 'react-native';
import Home from './pages/Home';
import { ScreenStack } from './node_modules/react-native-screens/lib/typescript/index';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { NavigationContainer } from '@react-navigation/native';

const Stack = createNativeStackNavigator();

const RootStack = () => {
  return (
    <Stack.Navigator>
        <Stack.Screen 
          name="Home"
          component={Home}
          options={{title: "Home Screen"}}
        />
         <Stack.Screen 
          name="AVFoundation"
          component={AVFoundationScreen}
          options={{title: "AV Foundation"}}
        />
         <Stack.Screen 
          name="MLKit"
          component={MLKitScreen}
          options={{title: "ML Kit"}}
        />
         <Stack.Screen 
          name="VisionKit"
          component={VisionKitScreen}
          options={{title: "Vision Kit"}}
        />
    </Stack.Navigator>
  )
}

function App(): React.JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';


  return (
    <NavigationContainer>
      <RootStack />
    </NavigationContainer>
  );
}

export default App;
