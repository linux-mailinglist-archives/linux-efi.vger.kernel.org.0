Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D643A5E7038
	for <lists+linux-efi@lfdr.de>; Fri, 23 Sep 2022 01:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiIVX13 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 19:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiIVX12 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 19:27:28 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B1010BB3D;
        Thu, 22 Sep 2022 16:27:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6DA355C009E;
        Thu, 22 Sep 2022 19:27:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 22 Sep 2022 19:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663889244; x=
        1663975644; bh=NATz2eZd4ruDPDhqkThpsKKoxTGUAMa5GGSs6QDuXBM=; b=k
        M0+o2rmNRaO8Mzt5yuSVbbU3gVbZMLMe+o2BRK7d6nkWMApDczUi8bReVTTHjp/3
        8jmAAmfEMaKBoBr7xpaG110ZWvf+vIUZu+12MPQii/wMtp6ccsG4KrHmdNZdCSXu
        kcIxa89ai2MZ9k+W5rKkVB2d4gVM3p01zbYEjU1odt/vUs8/nyCmBadO43xKfs/K
        Vq2/SlJSAyBpI9TIyQH5JPRHzIkwgFFkgZiO1UWVQJ9R08yDPsIqDXXwlTwB94bX
        BjEbnqFAIUk7O97JELpzRNkh9dencuaGWyKt4arvdFJ1I0GiKs/XKo7KKVsCSdvk
        rSHitjkVb9cpqYCqbOaWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663889244; x=1663975644; bh=NATz2eZd4ruDPDhqkThpsKKoxTGU
        AMa5GGSs6QDuXBM=; b=GJS2pqK3vOu+LYXtm2bNPC1WyCBSzfiafb3ggDbTdmfG
        YefNCO1IaWxCeOHqDDAbwMzWYjExEZ5IUO9FigiZ1VfXq6O9fnTiMP2nMii8VIdN
        K/1AJLCjd22SGD5SNGlOyoo5jbLt4D2tklCLAItQESe7yO83sxU3J8rfS38A1nP/
        stqiFV2Ff6yEfRJrEtRSNvRs7LdMCwLHaB3oPWewc+A8wdQXuizA/WNe3idEk82w
        yxLRyKBoeoXQbHqWot7mhLF2orGdkz3v7so+T0h/LUO6A5uX/4NsMaKq9SGFVwaB
        oZLXb4V4AOIoHzptRPaMdy4oswZTdfokGvL9ip6mCw==
X-ME-Sender: <xms:XO8sY_fxQNNFuDGrwxwftT8oArpLGxGILdG9oVcuf2sBL19ikbETmg>
    <xme:XO8sY1MMtdW5M5qiFJizRKrQcXoNQsXoDie4lW3rNH3Om12CXBa1WuvteB3NhQqV3
    GtDsu9Ebv7wb1o>
X-ME-Received: <xmr:XO8sY4gpDfXPfUtcXb251V2jM5wdquM-4wphTlul3MjfSbkBaSRC1WSTIQdk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefhedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:XO8sYw9LLqirQzTLsEYBvKS8rT4MD3FErmSloiYOD8idsaivxlWKWw>
    <xmx:XO8sY7szPaNVr5irpcqPtohMr70fKnGjhxnkZU7ovPJYuNjTf-jujw>
    <xmx:XO8sY_Gk09hhmmeIIWzrTj48Vt7j9XOZ-Hpp6C3gln9h7OCZIE3fMA>
    <xmx:XO8sY_jCuhQLoEAkS4nllisd1lQLjczzEZD4F6KhftqBjq90LyhVpg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Sep 2022 19:27:23 -0400 (EDT)
Date:   Thu, 22 Sep 2022 19:25:32 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v3] Support ESRT in Xen dom0
Message-ID: <YyzvWmcvvGq+TQ/R@itl-email>
References: <CAMj1kXEBfJUfTQ3THqqKxsU09_S98B_TjTECKwGM0WAv_5tZaA@mail.gmail.com>
 <7930b617-d473-94dd-c7e4-33ffa19da13e@suse.com>
 <CAMj1kXEJ9d3-8xa7rkczY7ur2zDm9CjqM7u1eEdHHmPG=Oo=xA@mail.gmail.com>
 <3671fd52-6034-7149-ebe4-f7560c0dc6b0@suse.com>
 <Yyu1xC7Tlf9sS7Ro@itl-email>
 <6f42a382-c5aa-ba16-f330-69a07476e2aa@suse.com>
 <Yyx3hlE/MDBeEdtu@itl-email>
 <CAMj1kXFoyTRKfGH2nMpi-EJRqLz9T_p+ZMM0x09UNJ-34-kS_Q@mail.gmail.com>
 <YyylgVqDMi9SDptq@itl-email>
 <CAMj1kXE8ZPxHS2BEEKyJNUKut0Peb2kb3CWMwuxxeyFhJk1DZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GRcGP6sBkPbgCb0x"
Content-Disposition: inline
In-Reply-To: <CAMj1kXE8ZPxHS2BEEKyJNUKut0Peb2kb3CWMwuxxeyFhJk1DZw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--GRcGP6sBkPbgCb0x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Sep 2022 19:25:32 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v3] Support ESRT in Xen dom0

On Fri, Sep 23, 2022 at 12:14:50AM +0200, Ard Biesheuvel wrote:
> On Thu, 22 Sept 2022 at 20:12, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Thu, Sep 22, 2022 at 05:05:43PM +0200, Ard Biesheuvel wrote:
> > > On Thu, 22 Sept 2022 at 16:56, Demi Marie Obenour
> > > <demi@invisiblethingslab.com> wrote:
> > > >
> > > > On Thu, Sep 22, 2022 at 08:12:14AM +0200, Jan Beulich wrote:
> > > > > On 22.09.2022 03:09, Demi Marie Obenour wrote:
> > > > > > On Wed, Sep 21, 2022 at 10:34:04PM +0200, Jan Beulich wrote:
> > > > > >> On 20.09.2022 18:09, Ard Biesheuvel wrote:
> > > > > >>> On Tue, 20 Sept 2022 at 17:54, Jan Beulich <jbeulich@suse.com=
> wrote:
> > > > > >>>>
> > > > > >>>> On 20.09.2022 17:36, Ard Biesheuvel wrote:
> > > > > >>>>> On Mon, 19 Sept 2022 at 21:33, Demi Marie Obenour
> > > > > >>>>> <demi@invisiblethingslab.com> wrote:
> > > > > >>>>>>
> > > > > >>>>>> fwupd requires access to the EFI System Resource Table (ES=
RT) to
> > > > > >>>>>> discover which firmware can be updated by the OS.  Current=
ly, Linux does
> > > > > >>>>>> not expose the ESRT when running as a Xen dom0.  Therefore=
, it is not
> > > > > >>>>>> possible to use fwupd in a Xen dom0, which is a serious pr=
oblem for e.g.
> > > > > >>>>>> Qubes OS.
> > > > > >>>>>>
> > > > > >>>>>> Before Xen 4.16, this was not fixable due to hypervisor li=
mitations.
> > > > > >>>>>> The UEFI specification requires the ESRT to be in EfiBootS=
ervicesData
> > > > > >>>>>> memory, which Xen will use for whatever purposes it likes.=
  Therefore,
> > > > > >>>>>> Linux cannot safely access the ESRT, as Xen may have overw=
ritten it.
> > > > > >>>>>>
> > > > > >>>>>> Starting with Xen 4.17, Xen checks if the ESRT is in EfiBo=
otServicesData
> > > > > >>>>>> or EfiRuntimeServicesData memory.  If the ESRT is in EfiBo=
otServicesData
> > > > > >>>>>> memory, Xen allocates some memory of type EfiRuntimeServic=
esData, copies
> > > > > >>>>>> the ESRT to it, and finally replaces the ESRT pointer with=
 a pointer to
> > > > > >>>>>> the copy.  Since Xen will not clobber EfiRuntimeServicesDa=
ta memory,
> > > > > >>>>>> this ensures that the ESRT can safely be accessed by the O=
S.  It is safe
> > > > > >>>>>> to access the ESRT under Xen if, and only if, it is in mem=
ory of type
> > > > > >>>>>> EfiRuntimeServicesData.
> > > > > >>>>>>
> > > > > >>>>>
> > > > > >>>>> Thanks for the elaborate explanation. This is really helpfu=
l.
> > > > > >>>>>
> > > > > >>>>> So here, you are explaining that the only way for Xen to pr=
event
> > > > > >>>>> itself from potentially clobbering the ESRT is by creating a
> > > > > >>>>> completely new allocation?
> > > > > >>>>
> > > > > >>>> There are surely other ways, e.g. preserving BootServices* r=
egions
> > > > > >>>> alongside RuntimeServices* ones. But as the maintainer of th=
e EFI
> > > > > >>>> code in Xen I don't view this as a reasonable approach.
> > > > > >>>
> > > > > >>> Why not?
> > > > > >>
> > > > > >> Because it's against the intentions the EFI has (or at least h=
ad)
> > > > > >> for this memory type. Much more than EfiAcpiReclaimMemory this
> > > > > >> type is intended for use as ordinary RAM post-boot.
> > > > > >
> > > > > > What about giving that memory to dom0?  dom0=E2=80=99s balloon =
driver will give
> > > > > > anything dom0 doesn=E2=80=99t wind up using back to Xen.
> > > > >
> > > > > While perhaps in principle possible, this would require special c=
asing
> > > > > in Xen. Except for the memory the initrd comes in, we don't direc=
tly
> > > > > hand memory to Dom0. Instead everything goes through the page all=
ocator
> > > > > first. Plus if we really were convinced boot services memory need=
ed
> > > > > retaining, then it would also need retaining across kexec (and he=
nce
> > > > > shouldn't be left to Dom0 to decide what to do with it).
> > > >
> > > > So how should dom0 handle the various EFI tables other than the ESR=
T?
> > > > Right now most uses of these tables in Linux are not guarded by any
> > > > checks for efi_enabled(EFI_MEMMAP) or similar.  If some of them are=
 in
> > > > EfiBootServicesData memory, they might be corrupted before Linux ge=
ts
> > > > them.
> > >
> > > Yes, this is an annoying oversight of the EFI design: the config
> > > tables are <guid, address> tuples, and the size of the table is
> > > specific to each table type. So without knowing the GUID, there is no
> > > way you can reserve the right size.
> > >
> > > Perhaps you could implement something like a hypercall in
> > > efi_arch_mem_reserve(), which is called by the EFI code to reserve
> > > regions that are in boot services memory but need to remain reserved?
> > > This is used for all config tables that it knows or cares about.
> >
> > On versions of Xen that support spawning multiple domains at boot
> > (instead of just dom0) this will be racy.  What about refusing to use
> > tables in EfiBootServicesData when running under Xen unless a hypercall
> > indicates that Xen has reserved all EfiBootServicesData memory?  Where
> > could such a check be placed?
>=20
> You could stick a check inside the for loop in
> efi_config_parse_tables() to cross reference every table address
> against the memory map when running on Xen, and disregard it if it
> doesn't meet your criteria.
>=20
> I take it the issue is not limited to x86?

Indeed the issue is cross-platform.  For Qubes OS, I wonder if a safer
approach would be to reserve all EfiBootServicesData memory by default.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--GRcGP6sBkPbgCb0x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmMs71kACgkQsoi1X/+c
IsGs/g//UTu+abXay03rXZ2nW5p6CsJQWGwF+Es58U0c1hJHgmp+nLyZdttBRgnt
49nGc43rbHCNODqXZu/R9TyK6gef1ZqaAiZyV2vHFitnhrbLz2VZFMNUwmpz6zbi
MA1SGQjYmfbIU5wU/6Nym8sF51CridQs8+UqVh9h3dbog6RWw9qvYYiz4xEe9cCi
w7alXoYFT2JdorwNX+heUDX2/TkaYtrzsVRUMJ+bOedGPOgqtw1f6AhicUJV1KZ/
ztszH/HxcdTO4c8rdYaIH6CKN8LIdQex6V/WNmio+dMq6fD5tDSVB9OBRqXZUbzk
sbEdnsJSL1/lwab5C6f/kP4+GDILJBU1747758MbviUtZ9zXaAj3G9o3ymYtnUuN
NcK2nneVI5Thz2Obmt3RRA7zWjJt827fzxQzIAl6bsSgiUHtg8eD5TUx7yxJIXgL
3F3J1ieo54ARic4+q4+9Bj7CIWFV+nN6CQgDpf5z16f2utgG+Y7Bi9iZ8z0j+TjE
uuaMqZpTMA5MYhaJZc0V12PEkSxj4mOSDm5MWH8mDWthOMp4qiRvuFOUKc2ok0Dq
joZl/hFN/zVa77+T687aPewkfPNc2m5ldag/04aZnyXC+jhP0dl9QRCotZyq+FYT
lQnxoN7KeQpBQn5D+qkNyHZtm1z4Wo7llrNFYVayXN+tQTSz6sQ=
=El6T
-----END PGP SIGNATURE-----

--GRcGP6sBkPbgCb0x--
