Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B9A5F229A
	for <lists+linux-efi@lfdr.de>; Sun,  2 Oct 2022 12:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJBKdw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Oct 2022 06:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJBKdr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Oct 2022 06:33:47 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B54340BF8;
        Sun,  2 Oct 2022 03:33:45 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 010911C0033; Sun,  2 Oct 2022 12:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1664706824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UiySFFLrKhPDj0Pm2sdnS3JMoIPjd26Ak6UmyKx8/JQ=;
        b=gufXr7Z3jMYQ+67ueSQZ6UQD+TMI4kD2NNQ9CnmH4AcWraakcviQBfme1LoZ87vAybSEbR
        mwr5sgOKP253IrGxpehlp+8wxJ1SN6OeV4CrpktF8TaPoZgK0a8XFDvoHh9fAhqEWbUQMX
        hWp07/YH+z628c7idudyz+4nFMdMwM8=
Date:   Sun, 2 Oct 2022 12:33:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-efi@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/mm: Disable W^X detection and enforcement on 32-bit
Message-ID: <20221002103336.GB10085@duo.ucw.cz>
References: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <20220923221730.1860518-1-dave.hansen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The 32-bit code is in a weird spot.  Some 32-bit builds (non-PAE) do not
> even have NX support.  Even PAE builds that support NX have to contend
> with things like EFI data and code mixed in the same pages where W+X
> is unavoidable.
>=20
> The folks still running X86_32=3Dy kernels are unlikely to care much about
> NX.  That combined with the fundamental inability fix _all_ of the W+X
> things means this code had little value on X86_32=3Dy.  Disable the check=
s.

> ---
>  arch/x86/mm/pat/set_memory.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 20b1e24baa85..efe882c753ca 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -587,6 +587,14 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgpr=
ot_t new, unsigned long star
>  {
>  	unsigned long end;
> =20
> +	/*
> +	 * 32-bit has some unfixable W+X issues, like EFI code
> +	 * and writeable data being in the same page.  Disable
> +	 * detection and enforcement there.
> +	 */
> +	if (IS_ENABLED(CONFIG_X86_32))
> +		return new;
> +

You are going from extreme to extreme. W^X is useful on x86-32 at
least in some configs, so it would make sense to detect and inform
about the issues (perhaps with something like KERN_INFO).

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYzlpAAAKCRAw5/Bqldv6
8js2AJ9KOBtSA7+UVKEK6gweUxSACtX66wCfe8bY/YS32QC4OQ5e2iFvp53VDGo=
=0diF
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
