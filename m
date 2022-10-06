Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D65F6CCD
	for <lists+linux-efi@lfdr.de>; Thu,  6 Oct 2022 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiJFRWz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 13:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiJFRWw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 13:22:52 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB54AD9B4;
        Thu,  6 Oct 2022 10:22:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 207A25C005E;
        Thu,  6 Oct 2022 13:22:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Oct 2022 13:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1665076967; x=
        1665163367; bh=8STzOSUlkj6+X64xjiGkmXhKTE+cDl1b43feNbW+ow4=; b=P
        P0SeOx88SYliO9qfSiBweM6lM8ZuA0Dp9rNrUMGLxl6sW3Z2ppdr9IeN/FmgDk7h
        abairpOKE/TCuyls9fbHPOOj0fGqwqQBsDhl2mn94pXYoJfPpCW75+14UnyWGJKO
        /WosixC040rt1Ev117gZj2wbRfF1VZviP9zdaCvkmwBZq38Fvhj0bWXzxqnsF0p3
        OkgEj2ItYsRoN1msd2IsrkfVE9D4s7/3gurJcY3ZD/1iWLvkLOvSzGwwYzD3p+He
        Pfh5FrSFo4ESQEJm9eNNQflo51sgFpd21UeUrd9qFrmgHPdBy6tMkxoMGRXb8QBK
        zKcLuXHjAdR7rlfQxAUlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1665076967; x=1665163367; bh=8STzOSUlkj6+X64xjiGkmXhKTE+c
        Dl1b43feNbW+ow4=; b=NnuWc3iyJ6+mS9G7gOQugAsUNykR9W6a5kS0rRTaJFI5
        fgFGH9ljgqiwrCLu/S6TvUGz6KYdarT08EJyFsC6MN+CSaedmNOqo3tpBGwMOkEt
        8oE4PZkvBwhKmdR6IFOR+Urz4b3NbPGd4zTsuF9NlZxfZZctt0nSLb3svEu1uSQC
        8YSt3Xt12mvJvhMJr/gcZ3xJnn9jBvsWy6QFaOLRpFDhVIMoM7ho1ZNGtMoSbW+J
        WqJk7ERdwAbAhDs/+0Z5mPpeshFUZ9buKp8LfjkScTfDle63YLW17dUxCGhdXZoO
        Sg+xzFbm1SbEqekp2eYyWdSRVfgWL+RzvWbbAVZDAg==
X-ME-Sender: <xms:5g4_Y37xuOCNThVXgIWhdnSa28tJ7eGEjoJzHou1Hq7pb_cvWjS69g>
    <xme:5g4_Y84i1AMQAIJN4E-cV_BYOEPPwReTDeHSYZyMzoCWGu4tmz4ZqypW2oaHtX2NG
    NS7y9VWCZM-wa0>
X-ME-Received: <xmr:5g4_Y-c94Okpkjrnycf7JpgdVHCFG2zdvD2kFsq_F4k5F5hqGgHr-j_fxsEv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffej
    geejgeffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:5g4_Y4JR77NZVKoPXNgMlBk13-qo87qtGLf62bp0Lf0khH9hKzVAmw>
    <xmx:5g4_Y7JEPLwL4O94T2zRVocnCe7oKAntvaRAnlKHQEZnajKuMK1VDg>
    <xmx:5g4_YxzIX3waId_SH9vC0exSxoR1x-Zotw20SPYUN7BoCe7pizxMfA>
    <xmx:5w4_Y4Bn5bQJunbq0_ISedoNI0uqMpHumgv7KRBFsSH6s5Y6SNyyeg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Oct 2022 13:22:45 -0400 (EDT)
Date:   Thu, 6 Oct 2022 13:22:34 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered
Message-ID: <Yz8O5ItPhtfpMfI2@itl-email>
References: <YzeaKjmls1YI/3ox@itl-email>
 <01d22092-8292-8ed7-ece7-9ca32d15bbce@suse.com>
 <YzxxXuovwQt3NskE@itl-email>
 <a0dc1158-01b1-4272-b86e-52f4996f0747@suse.com>
 <Yz3I2qwl243h9ZfZ@itl-email>
 <CAMj1kXHFi71SKQAQHEjZTLyp-YooRTYZ2-nqydRZA5hys7tkKw@mail.gmail.com>
 <Yz4yLyvX6un1rrqC@itl-email>
 <CAMj1kXFO9_yMw=_Fn2DBGgdYXgiK_OqafG5+TbJv1UKO1uQiJQ@mail.gmail.com>
 <Yz7polT2R2OlT1aT@itl-email>
 <CAMj1kXGe77iwnYXWR=Hjn8eL8-1hMZbprjU8bnYaFWJnRZfdfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q3Pdd5Vm/dbedYyy"
Content-Disposition: inline
In-Reply-To: <CAMj1kXGe77iwnYXWR=Hjn8eL8-1hMZbprjU8bnYaFWJnRZfdfw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--q3Pdd5Vm/dbedYyy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 6 Oct 2022 13:22:34 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v4 1/2] Avoid using EFI tables Xen may have clobbered

On Thu, Oct 06, 2022 at 06:19:35PM +0200, Ard Biesheuvel wrote:
> On Thu, 6 Oct 2022 at 16:43, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Thu, Oct 06, 2022 at 09:31:47AM +0200, Ard Biesheuvel wrote:
> > > On Thu, 6 Oct 2022 at 03:41, Demi Marie Obenour
> > > <demi@invisiblethingslab.com> wrote:
> > > >
> > > > On Wed, Oct 05, 2022 at 11:28:29PM +0200, Ard Biesheuvel wrote:
> > > > > On Wed, 5 Oct 2022 at 20:11, Demi Marie Obenour
> > > > > <demi@invisiblethingslab.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 05, 2022 at 08:15:07AM +0200, Jan Beulich wrote:
> > > > > > > On 04.10.2022 17:46, Demi Marie Obenour wrote:
> > > > > > > > Linux has a function called efi_mem_reserve() that is used =
to reserve
> > > > > > > > EfiBootServicesData memory that contains e.g. EFI configura=
tion tables.
> > > > > > > > This function does not work under Xen because Xen could hav=
e already
> > > > > > > > clobbered the memory.  efi_mem_reserve() not working is the=
 whole reason
> > > > > > > > for this thread, as it prevents EFI tables that are in
> > > > > > > > EfiBootServicesData from being used under Xen.
> > > > > > > >
> > > > > > > > A much nicer approach would be for Xen to reserve boot serv=
ices memory
> > > > > > > > unconditionally, but provide a hypercall that dom0 could us=
ed to free
> > > > > > > > the parts of EfiBootServicesData memory that are no longer =
needed.  This
> > > > > > > > would allow efi_mem_reserve() to work normally.
> > > > > > >
> > > > > > > efi_mem_reserve() actually working would be a layering violat=
ion;
> > > > > > > controlling the EFI memory map is entirely Xen's job.
> > > > > >
> > > > > > Doing this properly would require Xen to understand all of the =
EFI
> > > > > > tables that could validly be in EfiBootServices* and which coul=
d be of
> > > > > > interest to dom0.  It might (at least on some very buggy firmwa=
re)
> > > > > > require a partial ACPI and/or SMBIOS implementation too, if the=
 firmware
> > > > > > decided to put an ACPI or SMBIOS table in EfiBootServices*.
> > > > > >
> > > > > > > As to the hypercall you suggest - I wouldn't mind its additio=
n, but only
> > > > > > > for the case when -mapbs is used. As I've indicated before, I=
'm of the
> > > > > > > opinion that default behavior should be matching the intentio=
ns of the
> > > > > > > spec, and the intention of EfiBootServices* is for the space =
to be
> > > > > > > reclaimed. Plus I'm sure you realize there's a caveat with Do=
m0 using
> > > > > > > that hypercall: It might use it for regions where data lives =
which it
> > > > > > > wouldn't care about itself, but which an eventual kexec-ed (o=
r alike)
> > > > > > > entity would later want to consume. Code/data potentially usa=
ble by
> > > > > > > _anyone_ between two resets of the system cannot legitimately=
 be freed
> > > > > > > (and hence imo is wrong to live in EfiBootServices* regions).
> > > > > >
> > > > > > I agree, but currently some such data *is* in EfiBootServices* =
regions,
> > > > > > sadly.  When -mapbs is *not* used, I recommend uninstalling all=
 of the
> > > > > > configuration tables that point to EfiBootServicesData memory b=
efore
> > > > > > freeing that memory.
> > > > > >
> > > > >
> > > > > That seems like a reasonable approach to me. Tables like MEMATTR =
or
> > > > > RT_PROP are mostly relevant for bare metal where the host kernel =
maps
> > > > > the runtime services, and in general, passing on these tables wit=
hout
> > > > > knowing what they do is kind of fishy anyway. You might even argue
> > > > > that only known table types should be forwarded in the first plac=
e,
> > > > > regardless of the memory type.
> > > >
> > > > Which tables are worth handling in Xen?  I know about ACPI, SMBIOS,=
 and
> > > > ESRT, but I am curious which others Xen should preserve.  Currently=
, Xen
> > > > does not know about RT_PROP or MEMATTR; could this be a cause of
> > > > problems?
> > >
> > > dom0 only has access to paravirtualized EFI runtime services, so
> > > consuming RT_PROP or MEMATTR should be up to Xen (they describe which
> > > runtime services remain available at runtime, and which permission
> > > attributes to use for the runtime services memory regions,
> > > respectively)
> >
> > Xen does not do this right now.  I wonder if this could be the cause of
> > compatibility issues with various firmware implementations.
> >
> > > Looking through the kernel code, I don't think there are any that dom0
> > > should care about beyond ACPI, SMBIOS and ESRT. But as you suggest,
> > > that means Xen should just mask them in the view of the EFI system
> > > table it exposes so dom0. Otherwise, the kernel may still try to map
> > > and parse them.
> >
> > What about the BGRT and MOKvar?  I agree that Xen should not expose the
> > others.  Should it just hide the tables, or should it actually uninstall
> > them?  My intuition is that the second would be technically more
> > correct, but also more likely to trigger bugs in various firmware
> > implementations.
>=20
> BGRT is a ACPI table not a EFI configuration table, so I'd assume it
> is treated the same way as other ACPI tables

That actually surprises me.  Xen definitely needs to know about its
GUID, then.  Are there any other EFI configuration tables that Xen needs
to know about, or ACPI tables that might be outside of
EfiACPIReclaimMemory.

> MOKvar is a fallback for systems where it doesn't fit into a volatile
> variable IIRC but I am not sure if it is actually implemented
> anywhere, and what type of memory region it is expected to use.
>=20
> However, I'm not sure if it even matters, given that Xen loads the
> dom0 kernel not the firmware, right?

No idea.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--q3Pdd5Vm/dbedYyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM/DuQACgkQsoi1X/+c
IsEicxAA3lUz8SveZIU9v+BatOCM7Tuh3LE03CsRUtdBaA9JQKN3m8B3cHPJKVod
Bgtp5mcjVDJIQ34tJByBv/Pn3yvwc88kBeu9ePesE5Nz3rK5lCPhQy2KRGVtjB6j
LMvGiQlo4lpliXm+02+qCeYrvgtDTDG5zPdv69FQR/rP+gCRaEtQzCV2IC1kPpRK
6G4jpkcbsfj0KuSmrKduss/D29ji4lfbR7/kDFhmJGkXWnf5iSLCtTLlUgCPCQ09
q9ibVjp7/6kXspfzN6v70WsrPW426XGocEAtXw9QuIM6fnPptObxZa1ucnhfkJxY
HpRrqvip57raC6Kmpl8NLlpfbvGFpqOzimmAKVrN+4hWuE14Z1bOd7ETBU847vLb
FdAyI8nEuxD45fcAp01BqMfbQqP5Cf3uXVR1P+w9MLojxWrEkpeGr4eLBOuuThNz
NCuQ1EHBZAa25Phj9unbP8c5XtgghsqTNjF4TnySsUe+xCKxa1JQPreRwZwkDAWc
BQ5+vA2n9eC5X8lhUiIw67jet07cVW0IMnYowQKEMKt27L3UUI+FQ9w3GUZsfghr
dkwSdIrjvsi6yR8U/hBHvJ6CCgejaDPc4qYs78AX6EEPMB9KZaZtGlmQK2TXfitl
bxr5+KV67bxncdYeZrXTHn4rYRBkzw9HdzYJEE1Gk8Q+pNVrsVU=
=lYYE
-----END PGP SIGNATURE-----

--q3Pdd5Vm/dbedYyy--
