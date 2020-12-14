Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C7B2D9DFA
	for <lists+linux-efi@lfdr.de>; Mon, 14 Dec 2020 18:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502444AbgLNRlL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Dec 2020 12:41:11 -0500
Received: from mout.gmx.net ([212.227.17.21]:37099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502436AbgLNRlD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 14 Dec 2020 12:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607967565;
        bh=fE365REupbgYxc8nQoVLvXgiulsh6OYALjchxhRI9Rg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j+4q+QOxoxS7jA2ncqSYZ6E/i/94K3+DcMibnl4/ABz20agfc8W+St9wnNFwj+TAs
         gSOfCIsau7ks8tbP61JJZ+qIaJzwHqsgkTFjXLwp1+m5rCLCEHsKISZSPM7370yBRB
         yDN/2V9ixA/1ij9tr2lAYMLpHb6GKp5FTaebuVHo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.70] ([62.143.246.89]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1k8hQj3NqD-012JK3; Mon, 14
 Dec 2020 18:39:24 +0100
Subject: Re: [PATCH] efi/libstub: Allow EFI_NOT_FOUND on LOAD_FILE2_PROTOCOL
 calls for initrd
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        ard.biesheuvel@arm.com
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201214170122.4569-1-ilias.apalodimas@linaro.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <aa66cc54-f987-cdcd-05a7-4b63aa8b422d@gmx.de>
Date:   Mon, 14 Dec 2020 18:39:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201214170122.4569-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jdbcBDoawV7Vk4m69xIUURrrCr1h+zA2ME/jMSiXgk8x+AYisGG
 ZyqLwP2mUMLy7+YLQQUf90TKHHLHDERajN0O/n48f68dwL6n41nQJzfjuUDx6JenFhDJzkn
 tVtE/ATifebHcQgVfHhrMxAOod0w92nJLf0az5Bg77jK39Va7ALqOKvpwuKPjtGsUhNeMjC
 xgC4hNr6fHffl4QkVvR+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ehcb61pPR2E=:rDwXLneOJImPnwwy7lzM8J
 TZOoZEN6el0j8fY4gkyHzl3wixv3VheBfAIchiSvKniwgoh2oW2lz+5dKvVpnm9nGsa7eD/kc
 V+vew09AqsrQy677Z/HIKAtReMzwhRtDNn1+p4WNG0KuEO6uxjfTn1NzCPyuWcx6qhdUXq4vD
 Hfau31Vn+mVWJ+MjvzxlpGfNHj7hJEmws6a0CjAmme5d4gUsVw0WBlM9hy01fEQQRHspwssuP
 lIXXap/3coc1wo7ZarJ/q9a8gEWvEPbXZWZW7b910P39ZIdNOp4V3eLorue8JrnnFTE6Hb29z
 CFnEDs1FzK1zSsM+g3U7I3RFUHdDip3y+5hIbkTNbvrYlv2BDqOp8bU0teDTc5JDrWstg+7m5
 pb+2S1kPgfUz3iqUZjwOQFcpwlyCAF+RHWEvoLfwfZpQKgr6idGU/CHUYfVd1g6nDpEdL1Fsa
 9tI9K5fB6BS4ijpwq6ZXQ/cYEWxG/GZJSiYC6lK8OtXUrC5mkGYec4xpNHPowsZEnJnh/qXm6
 YNtPW1MPdt/2385WbJz1hM4Em9/sW4iIKQ+zxL8I2hTP152/fdmJKZywd3AhOYB347ygCKk4d
 Ezf66PAD/jW5y4xf6qEAQEK90XSAlNu0ZumBx9w5NyFiNogB8/yzuQWbHFY5rOA2/sndhboHj
 fo4jryEFHkjsjSN/Av5TjCWrU/ma+dleLV9VSb9aOmMTNjF4wnyeSG6mgE1WYFE0/rljqy1Ze
 Eyp+Uy1OrBF/9Cgk+1DAhJyDiMpPUcqrkgcvpXQ7lyuRjTR2ml7OrVpHdDR8ZA23qLyxk9Gv3
 N2yv8sPz+5cM/MYVxZO0+Tz+s7z+GVQROLcKwTc3+hYWH6ybuZBQUaQ8nID7zTbS54VjoK1kX
 qd5yIVqokWLzGXx7TkUg==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 14.12.20 18:01, Ilias Apalodimas wrote:
> At the moment the EFI stub tries to load an initrd from the
> cmdline provided option only if the LoadFile2 protocol does not exist
> on the initrd device path.
>
> This might prove problematic for EFI installers that need their own
> version of initrd to start the installation process and the firmware

Did you hit a real world case?

> installs the protocol but doesn't have a file to back it up (yet).
> Although some firmware implementations return EFI_NOT_FOUND, we
> currently return EFI_LOAD_ERROR in efi_load_initrd_dev_path() which
> stops the cmdline provided initrd to load.
>
> So let's change the behavior slightly here and explicitly respect the
> firmware in case it returns EFI_NOT_FOUND. This way we can load the
> cmdline provided initrd.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/fi=
rmware/efi/libstub/efi-stub-helper.c
> index aa8da0a49829..391aae2f0cde 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -560,6 +560,7 @@ static const struct {
>   * * %EFI_SUCCESS if the initrd was loaded successfully, in which
>   *   case @load_addr and @load_size are assigned accordingly
>   * * %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd devic=
e path
> + *   or if the firmware provides LoadFile2 but can't find a file to loa=
d
>   * * %EFI_INVALID_PARAMETER if load_addr =3D=3D NULL or load_size =3D=
=3D NULL
>   * * %EFI_OUT_OF_RESOURCES if memory allocation failed
>   * * %EFI_LOAD_ERROR in all other cases
> @@ -599,7 +600,14 @@ efi_status_t efi_load_initrd_dev_path(unsigned long=
 *load_addr,
>  				(void *)initrd_addr);
>  	if (status !=3D EFI_SUCCESS) {
>  		efi_free(initrd_size, initrd_addr);
> -		return EFI_LOAD_ERROR;
> +		/*
> +		 * Some firmware implementations might install the EFI

In U-Boot the filename is set a compile time. As the path may relate to
a removable medium, it would not make sense to check the existence of
the file when installing the protocol.

> +		 * protocol without checking the file is present and return
> +		 * EFI_NOT_FOUND when trying to load the file.
> +		 * If that's the case, allow the cmdline defined initrd to
> +		 * load.

U-Boot's implementation could also return EFI_NO_MEDIA if
CONFIG_EFI_INITRD_FILESPEC relates to a non-existent partition.

Why should we fall back to the command line in this case?

The whole idea of this protocol is to disallow the specification of an
initrd via the command line.

Best regards

Heinrich

> +		 */
> +		return status =3D=3D EFI_NOT_FOUND ? status : EFI_LOAD_ERROR;
>  	}
>
>  	*load_addr =3D initrd_addr;
>

