Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601A85E6A74
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiIVSMZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 14:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIVSMX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 14:12:23 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E994F6F6F;
        Thu, 22 Sep 2022 11:12:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3FB3E5C006A;
        Thu, 22 Sep 2022 14:12:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 22 Sep 2022 14:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663870340; x=
        1663956740; bh=5KUg0reqSIZKpByEeHPV1qhH2O4YtqXBthpOj14pdLk=; b=i
        AIvZ8ch/KvS+h2V6IRSMMbdAaTdFShUkMWKtI6sdzk+Wxj1rZvNqABiakXCl673f
        AhCKfbARYpMBVv4gbeELuo2563w3zjO70Ia0n2PbFD85OL93LmfHm5h4d5eyeCn8
        9nRqw4SUL4kwN7YNPQg0gF7h86lcs0ujFnmpm8pDr5u1iMQrmVdw+7u4pOnVzHsq
        XJhO6CFveVXX9jdcPaPcRkxSPG2VnhjuDguvifvNdHSwYmmahks2bCagSrnrujKe
        TK8Z2iB0biDfMQOJguAMEoKOk484LygrUMIClZowHwbnE21OH1E0rL5R7U9+Arbt
        rTonQ7HYCMMzLWmbf7kOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663870340; x=1663956740; bh=5KUg0reqSIZKpByEeHPV1qhH2O4Y
        tqXBthpOj14pdLk=; b=kFYcX0w0ENEotdONkAlUOhTVGrqLEx29hOmVYq4Ua/Nz
        +YYFWHWI8ZWACFsm2To8q6rKGTekzhNONxqOVdqnuM4vYza211t0z4jRIpUqSQou
        M7V8XFA4e3222jLI1+Rcu0kKaC7qB8B6Py/anhtXmpecu+PRSGpoyhAcQ966LryF
        P1aBHhYBrrx/njkRjMHYnSIJ4oAUHqELrQs0XmoBbIMxWQ2wNLI7DoEQRTwyOcfy
        C30R6C+DwKASQnabmyhd1n2f2F8ZrhkwBa/YcsfNjx81RQZF7DAEtOzvU2TWVg4e
        N3O9Qj8JYWwJgNKWxjLGlSuas3AbpjMR6XjfFKp2Kg==
X-ME-Sender: <xms:g6UsY6X-UdytPLqO6sIrxOkapGymVh4jUK10EuDXLVuHMfcwQYoUGQ>
    <xme:g6UsY2nGw5fwOwLTAIQWBhwcybIq5EdFgzzu1WG6EQAToJQ6hGU76m2lQKKhjc5r0
    Z3Totebe39DNZo>
X-ME-Received: <xmr:g6UsY-YoynDDzst0npPFO32-xlSrJU7cf6IJhik83xviPTVzvDAr0NaNCo0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:g6UsYxV6vRN875D2uodQI3IqKW1aGlguuzCoRx8gixFwqjHzOccfzQ>
    <xmx:g6UsY0md-6Cqqqabyyk-J2dEmEpt6codlwWn1t9KpSmzmWcuejbKiw>
    <xmx:g6UsY2cqpGhd_4oDe5amBu7bI-enAHfzD-QRv6LLlZSGGGFVQ86RFQ>
    <xmx:hKUsYyZXAIMK5xF-Z9Lp8Lhp4VJGeTcHYEss2qsmx4ID7rMgqAfwhA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Sep 2022 14:12:19 -0400 (EDT)
Date:   Thu, 22 Sep 2022 14:11:51 -0400
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
Message-ID: <YyylgVqDMi9SDptq@itl-email>
References: <20220919193257.2031-1-demi@invisiblethingslab.com>
 <CAMj1kXEBfJUfTQ3THqqKxsU09_S98B_TjTECKwGM0WAv_5tZaA@mail.gmail.com>
 <7930b617-d473-94dd-c7e4-33ffa19da13e@suse.com>
 <CAMj1kXEJ9d3-8xa7rkczY7ur2zDm9CjqM7u1eEdHHmPG=Oo=xA@mail.gmail.com>
 <3671fd52-6034-7149-ebe4-f7560c0dc6b0@suse.com>
 <Yyu1xC7Tlf9sS7Ro@itl-email>
 <6f42a382-c5aa-ba16-f330-69a07476e2aa@suse.com>
 <Yyx3hlE/MDBeEdtu@itl-email>
 <CAMj1kXFoyTRKfGH2nMpi-EJRqLz9T_p+ZMM0x09UNJ-34-kS_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SFzkhd+vEYb5WUsk"
Content-Disposition: inline
In-Reply-To: <CAMj1kXFoyTRKfGH2nMpi-EJRqLz9T_p+ZMM0x09UNJ-34-kS_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--SFzkhd+vEYb5WUsk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Sep 2022 14:11:51 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v3] Support ESRT in Xen dom0

On Thu, Sep 22, 2022 at 05:05:43PM +0200, Ard Biesheuvel wrote:
> On Thu, 22 Sept 2022 at 16:56, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Thu, Sep 22, 2022 at 08:12:14AM +0200, Jan Beulich wrote:
> > > On 22.09.2022 03:09, Demi Marie Obenour wrote:
> > > > On Wed, Sep 21, 2022 at 10:34:04PM +0200, Jan Beulich wrote:
> > > >> On 20.09.2022 18:09, Ard Biesheuvel wrote:
> > > >>> On Tue, 20 Sept 2022 at 17:54, Jan Beulich <jbeulich@suse.com> wr=
ote:
> > > >>>>
> > > >>>> On 20.09.2022 17:36, Ard Biesheuvel wrote:
> > > >>>>> On Mon, 19 Sept 2022 at 21:33, Demi Marie Obenour
> > > >>>>> <demi@invisiblethingslab.com> wrote:
> > > >>>>>>
> > > >>>>>> fwupd requires access to the EFI System Resource Table (ESRT) =
to
> > > >>>>>> discover which firmware can be updated by the OS.  Currently, =
Linux does
> > > >>>>>> not expose the ESRT when running as a Xen dom0.  Therefore, it=
 is not
> > > >>>>>> possible to use fwupd in a Xen dom0, which is a serious proble=
m for e.g.
> > > >>>>>> Qubes OS.
> > > >>>>>>
> > > >>>>>> Before Xen 4.16, this was not fixable due to hypervisor limita=
tions.
> > > >>>>>> The UEFI specification requires the ESRT to be in EfiBootServi=
cesData
> > > >>>>>> memory, which Xen will use for whatever purposes it likes.  Th=
erefore,
> > > >>>>>> Linux cannot safely access the ESRT, as Xen may have overwritt=
en it.
> > > >>>>>>
> > > >>>>>> Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootSe=
rvicesData
> > > >>>>>> or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootSe=
rvicesData
> > > >>>>>> memory, Xen allocates some memory of type EfiRuntimeServicesDa=
ta, copies
> > > >>>>>> the ESRT to it, and finally replaces the ESRT pointer with a p=
ointer to
> > > >>>>>> the copy.  Since Xen will not clobber EfiRuntimeServicesData m=
emory,
> > > >>>>>> this ensures that the ESRT can safely be accessed by the OS.  =
It is safe
> > > >>>>>> to access the ESRT under Xen if, and only if, it is in memory =
of type
> > > >>>>>> EfiRuntimeServicesData.
> > > >>>>>>
> > > >>>>>
> > > >>>>> Thanks for the elaborate explanation. This is really helpful.
> > > >>>>>
> > > >>>>> So here, you are explaining that the only way for Xen to prevent
> > > >>>>> itself from potentially clobbering the ESRT is by creating a
> > > >>>>> completely new allocation?
> > > >>>>
> > > >>>> There are surely other ways, e.g. preserving BootServices* regio=
ns
> > > >>>> alongside RuntimeServices* ones. But as the maintainer of the EFI
> > > >>>> code in Xen I don't view this as a reasonable approach.
> > > >>>
> > > >>> Why not?
> > > >>
> > > >> Because it's against the intentions the EFI has (or at least had)
> > > >> for this memory type. Much more than EfiAcpiReclaimMemory this
> > > >> type is intended for use as ordinary RAM post-boot.
> > > >
> > > > What about giving that memory to dom0?  dom0=E2=80=99s balloon driv=
er will give
> > > > anything dom0 doesn=E2=80=99t wind up using back to Xen.
> > >
> > > While perhaps in principle possible, this would require special casing
> > > in Xen. Except for the memory the initrd comes in, we don't directly
> > > hand memory to Dom0. Instead everything goes through the page allocat=
or
> > > first. Plus if we really were convinced boot services memory needed
> > > retaining, then it would also need retaining across kexec (and hence
> > > shouldn't be left to Dom0 to decide what to do with it).
> >
> > So how should dom0 handle the various EFI tables other than the ESRT?
> > Right now most uses of these tables in Linux are not guarded by any
> > checks for efi_enabled(EFI_MEMMAP) or similar.  If some of them are in
> > EfiBootServicesData memory, they might be corrupted before Linux gets
> > them.
>=20
> Yes, this is an annoying oversight of the EFI design: the config
> tables are <guid, address> tuples, and the size of the table is
> specific to each table type. So without knowing the GUID, there is no
> way you can reserve the right size.
>=20
> Perhaps you could implement something like a hypercall in
> efi_arch_mem_reserve(), which is called by the EFI code to reserve
> regions that are in boot services memory but need to remain reserved?
> This is used for all config tables that it knows or cares about.

On versions of Xen that support spawning multiple domains at boot
(instead of just dom0) this will be racy.  What about refusing to use
tables in EfiBootServicesData when running under Xen unless a hypercall
indicates that Xen has reserved all EfiBootServicesData memory?  Where
could such a check be placed?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--SFzkhd+vEYb5WUsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmMspYEACgkQsoi1X/+c
IsGXXhAAnE/hgx+C/LQQqtCsCSnYzvqC77o9FiGo+5shysRLPz4yFrb77xJYmcsb
yYpJKT6kafAc+ZRVysENbxgE2+uMlpyfBmFJOiJeQ84opYex4a+qbKAQB8G0SigY
yjBVgKBphFvBQWL+u1ZJwBBMfdWeMWZsyxbD/9PNiNaimNaJlAKN6LsmvSCQSCtf
oPT4Y6a/ZPptfDOM/1edls66ulNsJDGTguWKN0Eb6Jn7XT072Tx34JY7K/WiOxkC
XMZoHXpp34SC0Sugd58VRZKdikz2S5oGSYHaFrzlj32t9Hf7cu4nL1GzELK7h921
lmpnT5KH877qUi97HRZavrcu2ioJ+esTlyu63L59TxQCtoxUeE4a3vyfL/opnS/6
+1ys1NVAd69cA13tPhDwNH660LEIkZ9cCfxJncMmcLJ2At8xLqZkwCq7FekSV8ZL
wgsMozH8yjvBPbAlWJ98eXoBUfwIhnfal/t9IE3OAX0fuso1RIdmLNAZ9dlOXoPM
92R8KL4i6CcEdKD/G0ZNkjzkmIxEBC16yL2ViaKbJ6MTFs/NX4tkBWGWex/KZMjY
oOe9u4Ux+LUV5Jesj+q2K1g9f9Bb1uTdSbPdWXyDDsIfDZAgGXmc6qkiy3DDypk+
uhc5O20D+OJbttUg38B1CIs2T4JeL3Yky9w/rFzl2lrtkG74RSc=
=BTrF
-----END PGP SIGNATURE-----

--SFzkhd+vEYb5WUsk--
