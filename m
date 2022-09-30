Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6185F138C
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 22:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiI3UVg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 16:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiI3UVc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 16:21:32 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7B2166F21;
        Fri, 30 Sep 2022 13:21:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id ACA2032009DE;
        Fri, 30 Sep 2022 16:21:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 30 Sep 2022 16:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664569282; x=
        1664655682; bh=84YQ6t1Q62lDEfE85H9mFCEwx6xIrWnJ1go7THDuksI=; b=d
        BzXQfbJioxFl13JRwhDDRVWlna7IqFGwpswqsTZfAk7e7oW56bkRJccVdDmpq5q1
        RVfpdlwkzilQ+pkqPpqulH3t1/vamByed7X74XUvHFt54+1pZ5PqFJbCdPYKE6Ad
        mvsG0pmNUN4lVkgxP967a7mZBkcTaOAw9vA9k65bKKC/L1F1282Db2lhinwy9DA9
        zpUiJdTm0j4IHiN2Qu+9BXq6hHVV0bQsUosyVnWd9N9p9yYxoxFiTITW85slPE2g
        vKDwKf8W3nPy6JtmUQwp0TuiMIlZU5GcztZDXA/5oi5r4MB5Y3M6EiaAnYAM7Kn8
        xS407msLguGO8wkqp4eGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664569282; x=1664655682; bh=84YQ6t1Q62lDEfE85H9mFCEwx6xI
        rWnJ1go7THDuksI=; b=ErRJOnvvMEnQxfGMllCeFVhHvrLbPoGFlN2HBfK9IuAK
        bnwMhmytF6bzReu/BQp8QjwMAC7xCe82L1Pf8HLRg8/PkAFJ350x3KFlY68YuK6/
        +MokEcEjz7KnIEzt5QHQawltz5TQC2pim127Oh57SiFpK6GUlo7wO4Adwu/njcw0
        6/wC2VcWpvbeL4g6G66V1pkscqTiXPb4EQS636r/HbCUUKoBpF8JmyJEGuQlJ8Tc
        JxO8/I/MX5Ujqfyoop5wmzxAL3kDxnVjJJY0DqESPdTPsB2pGCaR1VuyjAlwCXv/
        eRVULSGqKZPvTpobNfdQrlMIEphXvUxrz7L/P3+K5A==
X-ME-Sender: <xms:wU83Y4jRR_LG3ct_iOXvQLJ_bFMgUJFM64l4HbAdkz0rYWUYDvK-Yw>
    <xme:wU83YxCDKhCAsruA_M83oaduQehVWmEB1ghGwFEUPgfNiVgViNaEC8tMHkxBWVYRN
    N4_zKgRtxXfDz0>
X-ME-Received: <xmr:wU83YwGG-r1sczKAmCtAYC9QRhtDGC4ryzMKlOR2B7wORM_334LKtCRpmzZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:wU83Y5Rg36NxSKFwm4LmnbuZ85gMhSK6ywrk3JewrF7qir7QpJB_IQ>
    <xmx:wU83Y1zblBOXX9GeDbljrQ8HR95o5ciVxcIcENqekBxsrAfentJmyw>
    <xmx:wU83Y36qLJWPg78tgdowm9T7NAn9lfKZrE1HF6VmTKFCpDL6PAPYXg>
    <xmx:wk83Y6r8mJgDz88AwS5Pqv2X4TTE3IEJzNTd4O6iIgf98VUClnpOpA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Sep 2022 16:21:21 -0400 (EDT)
Date:   Fri, 30 Sep 2022 16:20:51 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>
Cc:     Juergen Gross <jgross@suse.com>,
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
Message-ID: <YzdPv4+fYX3SG9P0@itl-email>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <5649176eacda434267f68676f1733d06c572d19e.1664298147.git.demi@invisiblethingslab.com>
 <CAMj1kXEs-o8jvNqRiW+Ue2i52RBgg4iktg8UONCACk8-Gx4XXA@mail.gmail.com>
 <YzczpIYop5olD4hj@itl-email>
 <CAMj1kXHGPzy9T1LcE8LX+woGtUGTzrDgbjDBJabJ+bwDVPbTag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yKB7OHjMbPEa6C9c"
Content-Disposition: inline
In-Reply-To: <CAMj1kXHGPzy9T1LcE8LX+woGtUGTzrDgbjDBJabJ+bwDVPbTag@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--yKB7OHjMbPEa6C9c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Sep 2022 16:20:51 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Support ESRT in Xen dom0

On Fri, Sep 30, 2022 at 09:11:19PM +0200, Ard Biesheuvel wrote:
> On Fri, 30 Sept 2022 at 20:21, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Fri, Sep 30, 2022 at 06:36:11PM +0200, Ard Biesheuvel wrote:
> > > On Fri, 30 Sept 2022 at 01:02, Demi Marie Obenour
> > > <demi@invisiblethingslab.com> wrote:
> > > >
> > > > fwupd requires access to the EFI System Resource Table (ESRT) to
> > > > discover which firmware can be updated by the OS.  Currently, Linux=
 does
> > > > not expose the ESRT when running as a Xen dom0.  Therefore, it is n=
ot
> > > > possible to use fwupd in a Xen dom0, which is a serious problem for=
 e.g.
> > > > Qubes OS.
> > > >
> > > > Before Xen 4.17, this was not fixable due to hypervisor limitations.
> > > > The UEFI specification requires the ESRT to be in EfiBootServicesDa=
ta
> > > > memory, which Xen will use for whatever purposes it likes.  Therefo=
re,
> > > > Linux cannot safely access the ESRT, as Xen may have overwritten it.
> > > >
> > > > Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootService=
sData
> > > > or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootService=
sData
> > > > memory, Xen replaces the ESRT with a copy in memory that it has
> > > > reserved.  Such memory is currently of type EFI_RUNTIME_SERVICES_DA=
TA,
> > > > but in the future it will be of type EFI_ACPI_RECLAIM_MEMORY.  This
> > > > ensures that the ESRT can safely be accessed by the OS.
> > > >
> > > > When running as a Xen dom0, use the new
> > > > xen_config_table_memory_region_max() function to determine if Xen h=
as
> > > > reserved the ESRT and, if so, find the end of the memory region
> > > > containing it.  This allows programs such as fwupd which require the
> > > > ESRT to run under Xen, and so makes fwupd support in Qubes OS possi=
ble.
> > > >
> > > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > >
> > > Why do we need this patch? I'd expect esrt_table_exists() to return
> > > false when patch 1/2 is applied.
> >
> > efi_enabled(EFI_MEMMAP) is false under Xen, so there needs to be an
> > alternative way to get the end of the memory region containing the ESRT.
> > That is what this patch provides.
>=20
> OK. I don't think we need that to be honest. When running under Xen,
> we should be able to assume that the ESRT does not span multiple
> memory regions arbitrarily, so we can just omit this check if
> !efi_enabled(EFI_MEMMAP)
>=20
> IIRC (and Peter would know), we are trying to filter out descriptors
> that are completely bogus here: zero lenght, zero address, etc etc. I
> don't think we need that for Xen.

Xen doesn=E2=80=99t uninstall bogus ESRTs, so there is no less reason to wo=
rry
under Xen than on bare hardware.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--yKB7OHjMbPEa6C9c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM3T78ACgkQsoi1X/+c
IsFx7g/7BRp/7YBEuzU1LNbSnhRm6J9VM6ymA3kACNbZTwvhMoFDGftYiS8N//Bf
275dq6kanlCN68p69Eksa6ze+GdEmgfdRzY0vbGdFSZXACLSySlIPBr7jRr/yXzp
5Ys2MZgfps8wwXCzpjIXq/lobVHPS+C9m5Rlf3rsrEaR2RMV+eaEZLtTSfCyOwGT
hKfkmte/pFShv0Z/TdSq9IT1l4CvyhFXJKMH2vyiQ8dF9Cfdw5heW2CLaD/WI1DA
0ddE23IMlLd9tGaxlL1Hce6wVMCWsu9KCghOQXDX6J9swv9jynPvx+fo3CzyC4Ng
98xq9LdZRs8dWiUTpaxtkFaqvkPbBO4l5SQx79NwEzI9sH/R8PN5a8qtWmzCXv3h
rjt7E1qYRYoi86in1ealzvb2jm09hMavAiXxHU/TpnT8kDpid2X4ztCWD2haYQm5
zBWFpAz4iNtDw2MkaoaIUnTmi9mAI2UxEZnIxF0EdIBis9eSn2yBrWFJGADFdCPU
pbNkJ6KVp02kwj8+Vmju56905z5Ny99wASK+DJlZl7TybUdXG3O4b+hPwhg4WjyQ
VFjY4rOoceNvnPI7BnuuGB6B0HJA8z8+ZgucaTPavbXmA1rjNy7LYKGbI3hIDWag
E4I/IB/8LT4lQdcckCtDln+0VSSMAWUBYoEuuBZihH85c4JwoGM=
=IY+Q
-----END PGP SIGNATURE-----

--yKB7OHjMbPEa6C9c--
