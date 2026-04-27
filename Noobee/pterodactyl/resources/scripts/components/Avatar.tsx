import React from 'react';
import { useStoreState } from 'easy-peasy';
import { ApplicationStore } from '@/state';
import tw from 'twin.macro';
import styled from 'styled-components/macro';

const AvatarBox = styled.div`
    ${tw`flex items-center justify-center rounded-full bg-blue-600 text-white font-bold`}
    user-select: none;
    font-size: 0.7rem;
    width: 100%;
    height: 100%;
`;

const _UserAvatar = () => {
    const email = useStoreState((state: ApplicationStore) => state.user.data!.email);
    const letter = email ? email.charAt(0).toUpperCase() : '?';
    return <AvatarBox>{letter}</AvatarBox>;
};

const _Avatar = ({ size = 48 }: { size?: number }) => {
    const email = useStoreState((state: ApplicationStore) => state.user.data!.email);
    const letter = email ? email.charAt(0).toUpperCase() : '?';
    return (
        <AvatarBox style={{ width: size, height: size }}>
            {letter}
        </AvatarBox>
    );
};

_Avatar.displayName = 'Avatar';
_UserAvatar.displayName = 'Avatar.User';

const Avatar = Object.assign(_Avatar, { User: _UserAvatar });

export default Avatar;
