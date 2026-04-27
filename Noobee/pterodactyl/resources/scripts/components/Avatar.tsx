import React from 'react';
import { useStoreState } from 'easy-peasy';
import { ApplicationStore } from '@/state';
import md5 from 'md5';

type AvatarProps = {
    size?: number;
};

const _Avatar = ({ size = 48 }: AvatarProps) => {
    const email = useStoreState((state: ApplicationStore) => state.user.data!.email);
    const hash = md5(email.trim().toLowerCase());
    const url = `https://www.gravatar.com/avatar/${hash}?s=${size}&d=identicon`;

    return (
        <div
            style={{
                width: size,
                height: size,
                background: `url("${url}") center/cover no-repeat`,
                borderRadius: '50%',
            }}
        />
    );
};

const _UserAvatar = () => {
    const email = useStoreState((state: ApplicationStore) => state.user.data!.email);
    const hash = md5(email.trim().toLowerCase());
    const url = `https://www.gravatar.com/avatar/${hash}?s=64&d=identicon`;

    return (
        <div
            className={'userAvatar'}
            style={{
                background: `url("${url}") center/cover no-repeat`,
                width: '100%',
                height: '100%',
                borderRadius: '50%',
            }}
        />
    );
};

_Avatar.displayName = 'Avatar';
_UserAvatar.displayName = 'Avatar.User';

const Avatar = Object.assign(_Avatar, {
    User: _UserAvatar,
});

export default Avatar;
