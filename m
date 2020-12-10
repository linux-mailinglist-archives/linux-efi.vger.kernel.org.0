Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B72D6B1B
	for <lists+linux-efi@lfdr.de>; Fri, 11 Dec 2020 00:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394197AbgLJWbZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Dec 2020 17:31:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:47963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405131AbgLJW0c (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 10 Dec 2020 17:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607639100;
        bh=7URLmzolxMREC32enWTWWnTNWyOm+MhitVxzu34SbmM=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=YcINTNOWlxyDM4+JQ92XShZwnd2pltN4jg5R9udv19HTqz3UXenin8rdXpRzPv8cz
         eKrUmblpHrRYwiavZOj9PqWJxpuUaNzcrDtUGrOdKmrcANkz+Nvuu41RX35k/pCT2L
         FBFml5jsYmg0NVAWGM9uGf1BpxPn2yyTr3NbfJIA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([62.143.246.89]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V4P-1k8TPt1MRL-013yGM; Thu, 10
 Dec 2020 22:49:10 +0100
To:     Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Ivan Hu <ivan.hu@canonical.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC] Documentation for /dev/efi_test
Message-ID: <0d27217e-15c4-32e5-0dc3-47b94116ad64@gmx.de>
Date:   Thu, 10 Dec 2020 22:49:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3AYM8Zp5TeY/xXUAv7fSWLEpWs5F99r66xB8IbuxRZ4gmka9n4Q
 YQe0zGfghVLNHbTgGtD7796lS3fCf7QgcB1tMSqg7EIETsMaYW6ZbUQ9VoOwAnLbVTg82ny
 cb7ShiZ6aR238dVMSFFdkIFu0Hi/239swWN1HbeTirKGKLgMFQOFKMDJn3iZDeCRRoI0TmD
 0u2u3A84pkfm1NptXHYFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ycO+UZuZ0IE=:VbPnMlOzETVqKaj/LMTnc4
 lH4BplfygMmmo+S0IOjiPhV1Pv3wMJTMJO2E2S5RQRZGZkYYYFD8HTD4LIxAsOHTVpgmsqoiK
 VA3qau4GHcYnxz0ydl+DgUGFcyyCvIuraGK1IzROFzCOHlMlBAAFnN8ckNGPKXwQrOTSn7hor
 cIWTgUf9ISi0v4lbcV69xj4L2UP9CoYNWyYWFXhppjWd5DMAMlK8nlYaQVK2mgCvi6ge3z06h
 S+FdFjKqU7AYmiq7ow60vvfQBrzBH7a9T6xyTO9/4uwy6K9K9D/FjpO2t6nb0///Crn9D1b2R
 rYblX5i0o7EWXZlXFiHqCplFoPhqwuHRI8VKqcFDOK4m4bkMMFc/k+M/imP2fUnoaDEkKvr7Z
 4KozzgVjErJSJb12z5wCizAJIF2J+bz4vMLDxsK8/3Psxj4dBithB0nTFOwwm5WKB7YaAYy5a
 Q699WKfEjhZ8Hi7zce4wIB+pfW1hjr/zigVDajN2dSH1I5xF5inJG4wWBu3yuZUlbnG35BMOc
 HkfQc2KvK0cgSHfhNaseByHokpk//E8wqX3KIw1n5t3sEK1E9XzvoPDS9Efzp7byLv4TwPmn7
 IjKdrw75n8W6wZOGsxrdjGRm+32jABVi4FcUSLKoBCsoShWrpCyVKAveMy7V3GhFtU2j3jop3
 mXkgWLBZTj60m3jVlGmp/qIX1PtZIbiGhR0jLhJgMmXrF5CYep7N2bwg6zPn46TxdjacpwQpo
 srDx+H4ukP3P4jItRmvpMXVnG8dEvFJz1/XjhsMp28D5rDOOvIgqWMGlfuIb0+LpWdcZpaUW2
 nw+b7JyA43ThTxtu01MHiKax7EU6ti6gScdiChagnLzXc9+uMB5TA50sVXLrpu4OcM7KVhM0O
 lHUenSIhtBf3OPAPFSRQ==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Ard, hello Jonathan,

to test UEFI runtime services we have CONFIG_EFI_TEST which provides
/dev/efi_test and a bunch of IOCTLs for excercising the runtime services
(cf. drivers/firmware/efi/test/efi_test.h).

Currently there is no user documentation for this ABI.

Where should the documentation for the ABI be put in the documentation
tree? Is this Documentation/ABI/stable/?

Can includes be referenced in Documentation/ABI/stable/ files using
reStructured text notation?

I am hesitant to put the description into the man-pages project as this
ABI is meant for testing only.

Best regards

Heinrich


