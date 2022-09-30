Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC735F160D
	for <lists+linux-efi@lfdr.de>; Sat,  1 Oct 2022 00:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiI3WX5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 18:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiI3WX4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 18:23:56 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33341A2A0C;
        Fri, 30 Sep 2022 15:23:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D443932009A8;
        Fri, 30 Sep 2022 18:23:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 30 Sep 2022 18:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664576630; x=
        1664663030; bh=RX384jPlUWMAwZzt1xsK9je9R67ehV0OxhWWNtDc/gk=; b=k
        pD7cEtjbCxE5nVCLEl/0YbAgI6yENgCfHjBA57XcStaWJyv6QXYfjknx0W7MDM9t
        vyh08oGvHiRvNSTvd0utQKRno1Nshjbr9spNXjkMC/phqsttU8kI6ymP8rhVnlFb
        wvBLEuLRZoa97gJIrQS7IJf2D0Lt02IhT9cFXe2mGjdKvWLLsquf0zddjFCg9wqs
        ljJ3KS8S+smFRnSJtQPKEh3qYqmnhh3yXxJbDwLEIDNIBeZbBaATmvUXq2c3G/Gh
        7KSpgd8PwlvaxA9yj4HHNKXqPfo6Xvrh3Sv5jUuiaVhmSdsjlqmrcxcypHrhOavj
        w7vFQmrsUbbRMsrHhKItQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664576630; x=1664663030; bh=RX384jPlUWMAwZzt1xsK9je9R67e
        hV0OxhWWNtDc/gk=; b=pXvbizsEhFw8zh6954MAZ+w4xmpNnTLvhevaVkLwpVtD
        Dol0MkD1QAowrlujkHWwpoM68NT8bh31071mehu6aDzo6cvCA7nNgskyILXqo/+I
        K+euqrbCNOUx3TjUKCEHqhZVprZzEkaXb9YhXVNWm9YfYJE/ljzxS0umjrydjsbA
        VeB4+N5YrZi+4OfpJLWuuJAjEtcIYJ8ff0+SJyo99UtjDX0HAeXxNJFQUTiAQ5O5
        k0sSg3Zi/zkwd+DxNXLIgOmSy6Z4g3ndGSQxuzonARGC/287p8+iZVkhXxtZdviM
        kZz46uFz29qyznAh/GS+qNH6v8KxWHxsBQtKX+OtDA==
X-ME-Sender: <xms:dmw3Y48Y6NRqZOgJQmWiJ4FcbPaldQwGyN0635o1E-UYQrdE-ShpcA>
    <xme:dmw3YwsLrRouNCjprmMBMKAOJTA3Fi6NEdC3HffUmPZ-Dx6OlxASz6RIrKgqwZta8
    ijAPgZUZ8k6F_Y>
X-ME-Received: <xmr:dmw3Y-DtHYNacu6PUV7LtABJ9zOwscyapSM1Na35pAx6rcex4V6YAmJnJNKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehfedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:dmw3Y4f02IbTKAUidMlbwwVzw5Beq2VGhWxWpnrSB_4iGXQCcTMzIQ>
    <xmx:dmw3Y9MryRAwmSdl7vHrlDHob_4mAC7nG2Z-QnZpuVAiwj9RIBw6hA>
    <xmx:dmw3YynXccSChRxNHVlRfxhw8XliAu4a6IFHbaW-nvGvd3jiADHDuQ>
    <xmx:dmw3Y-FYbmHbJmmNgwONzEMRrH6uK3isHiSFoyWM9JvMPRRZVWFaqw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Sep 2022 18:23:49 -0400 (EDT)
Date:   Fri, 30 Sep 2022 18:22:48 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Jones <pjones@redhat.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Support ESRT in Xen dom0
Message-ID: <Yzdsc0FeGNk6h/me@itl-email>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <5649176eacda434267f68676f1733d06c572d19e.1664298147.git.demi@invisiblethingslab.com>
 <CAMj1kXEs-o8jvNqRiW+Ue2i52RBgg4iktg8UONCACk8-Gx4XXA@mail.gmail.com>
 <YzczpIYop5olD4hj@itl-email>
 <CAMj1kXHGPzy9T1LcE8LX+woGtUGTzrDgbjDBJabJ+bwDVPbTag@mail.gmail.com>
 <YzdPv4+fYX3SG9P0@itl-email>
 <CAMj1kXGTZZmW=QZOL1FvrsBLsvFzN1GkvZCotuZ-C-gBVGY6CQ@mail.gmail.com>
 <CAMj1kXFJa4sSDEkRwTXTntJcJrtshNofU6LaZOWtzMbp56cXXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O0m4X08RcO4y0b4+"
Content-Disposition: inline
In-Reply-To: <CAMj1kXFJa4sSDEkRwTXTntJcJrtshNofU6LaZOWtzMbp56cXXQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--O0m4X08RcO4y0b4+
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Sep 2022 18:22:48 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Peter Jones <pjones@redhat.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Support ESRT in Xen dom0

On Fri, Sep 30, 2022 at 11:24:37PM +0200, Ard Biesheuvel wrote:
> On Fri, 30 Sept 2022 at 22:59, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 30 Sept 2022 at 22:21, Demi Marie Obenour
> > <demi@invisiblethingslab.com> wrote:
> > >
> > > On Fri, Sep 30, 2022 at 09:11:19PM +0200, Ard Biesheuvel wrote:
> > > > On Fri, 30 Sept 2022 at 20:21, Demi Marie Obenour
> > > > <demi@invisiblethingslab.com> wrote:
> > > > >
> > > > > On Fri, Sep 30, 2022 at 06:36:11PM +0200, Ard Biesheuvel wrote:
> > > > > > On Fri, 30 Sept 2022 at 01:02, Demi Marie Obenour
> > > > > > <demi@invisiblethingslab.com> wrote:
> > > > > > >
> > > > > > > fwupd requires access to the EFI System Resource Table (ESRT)=
 to
> > > > > > > discover which firmware can be updated by the OS.  Currently,=
 Linux does
> > > > > > > not expose the ESRT when running as a Xen dom0.  Therefore, i=
t is not
> > > > > > > possible to use fwupd in a Xen dom0, which is a serious probl=
em for e.g.
> > > > > > > Qubes OS.
> > > > > > >
> > > > > > > Before Xen 4.17, this was not fixable due to hypervisor limit=
ations.
> > > > > > > The UEFI specification requires the ESRT to be in EfiBootServ=
icesData
> > > > > > > memory, which Xen will use for whatever purposes it likes.  T=
herefore,
> > > > > > > Linux cannot safely access the ESRT, as Xen may have overwrit=
ten it.
> > > > > > >
> > > > > > > Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootS=
ervicesData
> > > > > > > or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootS=
ervicesData
> > > > > > > memory, Xen replaces the ESRT with a copy in memory that it h=
as
> > > > > > > reserved.  Such memory is currently of type EFI_RUNTIME_SERVI=
CES_DATA,
> > > > > > > but in the future it will be of type EFI_ACPI_RECLAIM_MEMORY.=
  This
> > > > > > > ensures that the ESRT can safely be accessed by the OS.
> > > > > > >
> > > > > > > When running as a Xen dom0, use the new
> > > > > > > xen_config_table_memory_region_max() function to determine if=
 Xen has
> > > > > > > reserved the ESRT and, if so, find the end of the memory regi=
on
> > > > > > > containing it.  This allows programs such as fwupd which requ=
ire the
> > > > > > > ESRT to run under Xen, and so makes fwupd support in Qubes OS=
 possible.
> > > > > > >
> > > > > > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.co=
m>
> > > > > >
> > > > > > Why do we need this patch? I'd expect esrt_table_exists() to re=
turn
> > > > > > false when patch 1/2 is applied.
> > > > >
> > > > > efi_enabled(EFI_MEMMAP) is false under Xen, so there needs to be =
an
> > > > > alternative way to get the end of the memory region containing th=
e ESRT.
> > > > > That is what this patch provides.
> > > >
> > > > OK. I don't think we need that to be honest. When running under Xen,
> > > > we should be able to assume that the ESRT does not span multiple
> > > > memory regions arbitrarily, so we can just omit this check if
> > > > !efi_enabled(EFI_MEMMAP)
> > > >
> > > > IIRC (and Peter would know), we are trying to filter out descriptors
> > > > that are completely bogus here: zero lenght, zero address, etc etc.=
 I
> > > > don't think we need that for Xen.
> > >
> > > Xen doesn=E2=80=99t uninstall bogus ESRTs, so there is no less reason=
 to worry
> > > under Xen than on bare hardware.
> >
> > That may be true. But if Xen needs dom0 to be able to cross reference
> > the EFI memory map, it should provide one (and set EFI_MEMMAP to
> > enabled).
>=20
> Btw the efi_mem_reserve() for the ESRT is also redundant if it is
> guaranteed to be in RT services data or ACPI reclaim memory.

It=E2=80=99s needed on bare hardware.  On Xen it=E2=80=99s unreachable code.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--O0m4X08RcO4y0b4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM3bHMACgkQsoi1X/+c
IsELVxAArRvWRhFqD/HZjNwD8miJSVhkUC762UgZ3NMbiQ0XEB+cjEpOxs6cEGWg
zyclHhXXkl2SUxuOC/PyIDj5WngwTIHGmGxvWEnq4zr4PAJWYptR1MeAo4zYWU1k
dBcBH/GZ8+ofW3hjfQdS9B8mnJQanp4BubEN0wY9mQOPetx8Fh0my7Pz36xVuUhf
Nl1QgdrB8+Akmya4m7KN0ZxdMTm+e/QNSWogtsCpNls+nNDo6Rz7rjsKZJVpULQW
3GyptvapCv/tneLk7XgevsTP2FqWIIkV9DHag8HOrMCdv26xkyH2BrRXAYOvMzae
N5H6dJYuZsdAnRptOzD74OeRRHo7Jgeb6oiqRSmmVG4VdfSVMrnJ5k4ZoN3tb0bx
lBgWDLVQRwoqdYDP6i0d5sf5ZPe+iopD2L1U2+doE8MfNETOxF9BRXolzYS1qwzS
w9ypAkP0NymMO2yCpDxm5mpNwyK/fr40SPBx+E0HgqezKAB5JimPuNI2B54Gb7P7
pbn24u3NyLDnEKSMOaDUmaExTVQqfv4vHmhLYnxya0+bWSqzQ1ia/VAI7SfHZqR7
xwOkstQ1VDwSnZsVoZJebsGDEg5G3B3G21MPFuQd2I6G2KPJRQlQG+kqlLn0vV4J
rJWlWzvlSQZNtoh0h3HL8+KfiT8ztRBJmDfKnCfxB14LWGOVBHw=
=FSrg
-----END PGP SIGNATURE-----

--O0m4X08RcO4y0b4+--
