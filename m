Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B2B166028
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 15:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgBTO4L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 09:56:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:44909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgBTO4L (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Feb 2020 09:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582210551;
        bh=CHF7AYidt06ujEcZ1fOKJmq6/alZwRrRiw26IV2N2fE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gw/TGKyN5zRkyjS2Sh3CN8b9JC9utYR1WAfa1XNWDRoKjT/fhFZn6IVVl5f9Gk804
         Ev07b09EV2xWxG6oYvsXzbykbqcL6RhdwoSjdo1MB2UybToND0Ws3uWHBa6SLPcM2C
         gCmITFjTQzw4CGV40WrJv2a2aTXkIVGPnEa1vwss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.43.155] ([89.204.155.192]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1po0-1j2aJr2GaW-002Gin; Thu, 20
 Feb 2020 15:55:51 +0100
Subject: Re: [RFC PATCH 0/3] efi: put an API version number in the PE/COFF
 header
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     lersek@redhat.com, leif@nuviainc.com, pjones@redhat.com,
        mjg59@google.com, agraf@csgraf.de, ilias.apalodimas@linaro.org,
        daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        James.Bottomley@hansenpartnership.com
References: <20200220110649.1303-1-ardb@kernel.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <4d921ba6-5a34-4dfc-2a58-588933e995b7@gmx.de>
Date:   Thu, 20 Feb 2020 15:55:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220110649.1303-1-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eg0Toh0HpKo5FXiVk7tDM0RsEj5pkHAKL6MXcf/zj/3llv1XQX0
 PEFGNQpwSHTIQqkkj9yWyBhMy9eXiiQiCra9pWAxzxWtLtcn1l0c2Du+/IGzOG3+neb/Tgh
 Ekw/EceLtue5qO26BvyaC0fckXDLrNaG+krgQIGZAmTjvcQGyjvXH6vkgQPO270x4Crg0se
 btWWw3qqFVbrQKVl6CGfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ExrsSivJzuU=:nr1J6Rt8tICqrVnR3AFJOS
 5W1/blhjgIqM1W3yGKQ7vHzAfUFVCBuVIJTCBPXBZS+uRdozbsLJZmizzmb4w3JOdSBu4UrWr
 Zdg94GKna50pwIu3q1gwdD96dgLpmV0OkyYhyZe62jL4T3I4yNlYrM36ThQDok+oqS9nUxze7
 KcOf3azRntINenruQ7unGHiW5mWbK3x1u3Hx5IaoPQ2vfmnkUJ+bj3TaPG1UwlArlpmoCT4Uc
 V6W4fXeqsNagH5Nsqm2tb59+s5nF7gBs2MX/POZIQNBaZtpkhYGjqmm+cxqxdestlWxDvGb60
 SkVK9w41l5vrMcB5mxzNuoI8muqKbBTPyRbiVlHBozBGOk7mi9L3upqPthM5W/cxOorrPEjYI
 PJOzs0vTGlIoAkxkFE3MvPNgwy4QSZbXx1NT80hxk+6gXG4FiWbcSAsr1YFRAHhlN19X1seEp
 R29VFxmmZQo8HTmfrNpwMW4HvJbMaNnHfV4U2VoHc/vHtJcmiUPFg5uuEZtkDdtz7dAlubDCJ
 FPCkWHOtVl2qEJKZ95GiWAZoMJB9Pz6uImoUp1wPRARwEzK4O4QwNooBevffBYvUZLl0qdzZd
 14HGw3cpOcxtttgeJe2FPNdyKmJVc4zRfI/ZTY9C7gyM19u0zgqyrWgNULrIeFU+gCjHn6eUq
 IK8lbjv2sSZTtiGJmbsAFmNxor1dSv6HFS34VEP2C3tFXDVF6AOn/ZTBvcaR3OOmxEzzXdKTw
 IjUcsC3NL55VttfVcXEGFUkACzBaKeM+hfpXw6Mjf1dMK2Wl58WA5Yqehiie6OC3vmW5mAjsv
 PC+Sp9gU7+EhkYqo+BhXjHVYu8gY6E0UlzqeANquf7W9IyISQo0SnSSxYJUGxz2yE1Z00Gn85
 GsZ9UmlEpwLq1vUxPjYfpkBu4i8wAGH7WOSLDAJCpdFVbk76wrHrlBXlkz1D94LHaY6G4OHSZ
 a8QkADeF6sYGs0IjU+G85a4fW0Vo//0WLSVVDPMnpQiT6XUfiy3bDiv0f3or9qoH5s7sVjzsh
 DLxAncJBFxz9sYZlZxV5PRNikBJF8j9nh+pFCyLDmAHl67BW5erlM3Vn6UCLh6I8Rq/JHnFFP
 7AQt8ijR74wYM1R2MmTpmhcShnmHnaDXqzM1ar0mHfZ8hEfgf/9j6ShWbgCQYyKI8Nj/fJYeg
 N3zaGlJjI9E0EwiWTDsXhBgPdvTRUk+ZDYQxhDJ8tfmTdBthXm1+S4UHNoIKlMXeTmK63aS0a
 6K7zOWIhNeAkYn+ET
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 2/20/20 12:06 PM, Ard Biesheuvel wrote:
> After having added new ways to load the initrd and the mixed mode kernel=
,
> we will need to tell the loader about this, so it can use the new, gener=
ic
> method if supported, and fall back to the existing method(s) otherwise.
>
> This is an RFC - if there are better ways to record this in the image
> somehow, please shout.


Hello Ard,

for boot loaders like GRUB I understand that the boot loader could use
the initrd file path from its scripts to prepare a
EFI_LOAD_FILE2_PROTOCOL matching the loaded kernel.

I am not sure about the requirements for a firmware.

Up to now the U-Boot UEFI sub-system does not care about initial RAM
disk images at all. With Ilias suggested patch series U-Boot could offer
a file from a fixed file location via a EFI_LOAD_FILE2_PROTOCOL.

Is there anything else you expect a firmware like U-Boot or EDK2 to do?

Best regards

Heinrich

>
> Cc: lersek@redhat.com
> Cc: leif@nuviainc.com
> Cc: pjones@redhat.com
> Cc: mjg59@google.com
> Cc: agraf@csgraf.de
> Cc: ilias.apalodimas@linaro.org
> Cc: xypron.glpk@gmx.de
> Cc: daniel.kiper@oracle.com
> Cc: nivedita@alum.mit.edu
> Cc: James.Bottomley@hansenpartnership.com
>
> Ard Biesheuvel (3):
>    efi/x86: Use symbolic constants in PE header instead of bare numbers
>    efi/libstub: Introduce symbolic constants for the stub major/minor
>      version
>    efi: Bump the Linux EFI stub major version number to #1
>
>   arch/arm/boot/compressed/efi-header.S |  4 +-
>   arch/arm64/kernel/efi-header.S        |  4 +-
>   arch/x86/boot/header.S                | 64 ++++++++++----------
>   include/linux/pe.h                    | 21 +++++++
>   4 files changed, 58 insertions(+), 35 deletions(-)
>
