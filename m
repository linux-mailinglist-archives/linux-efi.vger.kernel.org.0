Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF485F3366
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 18:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiJCQXG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 12:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJCQXE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 12:23:04 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53BF1CB3E
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 09:23:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D9D98320027A;
        Mon,  3 Oct 2022 12:23:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 03 Oct 2022 12:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664814180; x=
        1664900580; bh=V76H3KZNlariQygngrqJIM3h4UgJ80sdU4g8vuPLVuA=; b=S
        0hd6yjQ0oDO6vM5Hf7U9npNc1moydAPRPN+jNQuc3Q8xKo00KvlgrLfQg+Yyc+QO
        kVRSPuZK/2ZFBNKjtTL7vVT8vgD5Ssavfuh8C6SP6uzbWA70VI4yEPbkdnJSbg/l
        qdG74SVdpuKhtIyGbSoZWaI1yN+93ety21aX0WtTn5hQVlCcXXqvz3TdrW88Og0W
        hyGgh/0JQVh4tmwWgXApzhxm2mwig+HiOgg6ayjcNIPdn9mjCQx/GCrld3VeKS5w
        7qlud+vb2JhRVNh1Yz29fxQQnaYlRiLL3dAurrq8Dp2BF6e6Bc17YYX0rk0HYCam
        fHCkjUWeZf+ZuMPSy55Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664814180; x=1664900580; bh=V76H3KZNlariQygngrqJIM3h4UgJ
        80sdU4g8vuPLVuA=; b=ny0oHhOpzHgUvmsM3YC3NJTeIOUtYySFs08Ps0hs/z10
        qM+BSX8q9v+d/mxtGoC7t1dcwPQ8XAOxylXGfqL2kJVSxRD9l6znxbiHFwKcdRN5
        VqPsQPvTtMoIv2IknBTxLq2QiK1ACa3X1e/VV/0+2bwD68vM515KOASvelOVXByh
        sN8182anyV6NFpF/2FONjYAuVhTIQf/At0zHzAp9LBs7tVQ8AmIbP6DJzvVT49vN
        VoMBXIQYJX6GP8a+RCxRuLU8uyPYqy8KgmnUuq6caKIat678XlX1DwRvlewwDy7e
        ham0tHqBlTtUisabQ2bE0EBBs8F/liIx7wId2CN3Uw==
X-ME-Sender: <xms:ZAw7Y7QxtctgMcoRA23wMZ-2hO6872gwPdQ56b8NjKLWygmOu1gXSw>
    <xme:ZAw7Y8z9s7iQiZPy1RDpuNH2wz_UYg40sJaf6TLQ_PcQoA6-4_lt5pzutaETztb_V
    ShE5NTFKEyTWs0>
X-ME-Received: <xmr:ZAw7Yw2wGDLGomVUOnxlQ5Ub2Z3MbrqIxwGW0gwIKyTI7coDfTr6lSxK6j6O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepiefgudefjedujeelvddtgfegueei
    hfeugfdtgfevkedtkefgledvtddvvdekheeknecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:ZAw7Y7APjlnzuKslphWG-2L2uSADN9SfBFSiyjiEQvvQyYXrSIcEHw>
    <xmx:ZAw7Y0iSGBbV5ehzgHgPN6KoJebfUr0DoocULDy9KdOra4OXtupXGw>
    <xmx:ZAw7Y_qUKUfJWUqvCMOGIo8XYIKvWaCvLCqPzjFKHiax-LpzeMkQHQ>
    <xmx:ZAw7Y3N8BhLNjrddhZp5VlV8HOOYZB0jLHp9xduXCaqUrrhm6tPkfQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Oct 2022 12:22:59 -0400 (EDT)
Date:   Mon, 3 Oct 2022 12:22:54 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Xen developer discussion <xen-devel@lists.xenproject.org>,
        Peter Jones <pjones@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v2 5/6] efi: xen: Implement memory descriptor lookup
 based on hypercall
Message-ID: <YzsMYfEwmjHwVheb@itl-email>
References: <20221003112625.972646-1-ardb@kernel.org>
 <20221003112625.972646-6-ardb@kernel.org>
 <Yzr/1s9CbA0CClmt@itl-email>
 <CAMj1kXEXhDXRSnBp8P=urFj8UzzeRtYS9V8Tdt9GSrZTnGRFhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t6nMBPUwd7mkm4Ai"
Content-Disposition: inline
In-Reply-To: <CAMj1kXEXhDXRSnBp8P=urFj8UzzeRtYS9V8Tdt9GSrZTnGRFhA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--t6nMBPUwd7mkm4Ai
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 3 Oct 2022 12:22:54 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org,
	Xen developer discussion <xen-devel@lists.xenproject.org>,
	Peter Jones <pjones@redhat.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v2 5/6] efi: xen: Implement memory descriptor lookup
 based on hypercall

On Mon, Oct 03, 2022 at 05:59:52PM +0200, Ard Biesheuvel wrote:
> On Mon, 3 Oct 2022 at 17:29, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > On Mon, Oct 03, 2022 at 01:26:24PM +0200, Ard Biesheuvel wrote:
> > > Xen on x86 boots dom0 in EFI mode but without providing a memory map.
> > > This means that some sanity checks we would like to perform on
> > > configuration tables or other data structures in memory are not
> > > currently possible. Xen does, however, expose EFI memory descriptor i=
nfo
> > > via a Xen hypercall, so let's wire that up instead.
> > >
> > > Co-developed-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  drivers/firmware/efi/efi.c |  5 ++-
> > >  drivers/xen/efi.c          | 34 ++++++++++++++++++++
> > >  include/linux/efi.h        |  1 +
> > >  3 files changed, 39 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > index 55bd3f4aab28..2c12b1a06481 100644
> > > --- a/drivers/firmware/efi/efi.c
> > > +++ b/drivers/firmware/efi/efi.c
> > > @@ -456,7 +456,7 @@ void __init efi_find_mirror(void)
> > >   * and if so, populate the supplied memory descriptor with the appro=
priate
> > >   * data.
> > >   */
> > > -int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > > +int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > >  {
> > >       efi_memory_desc_t *md;
> > >
> > > @@ -485,6 +485,9 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory=
_desc_t *out_md)
> > >       return -ENOENT;
> > >  }
> > >
> > > +extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out=
_md)
> > > +      __weak __alias(__efi_mem_desc_lookup);
> > > +
> > >  /*
> > >   * Calculate the highest address of an efi memory descriptor.
> > >   */
> > > diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
> > > index d1ff2186ebb4..74f3f6d8cdc8 100644
> > > --- a/drivers/xen/efi.c
> > > +++ b/drivers/xen/efi.c
> > > @@ -26,6 +26,7 @@
> > >
> > >  #include <xen/interface/xen.h>
> > >  #include <xen/interface/platform.h>
> > > +#include <xen/page.h>
> > >  #include <xen/xen.h>
> > >  #include <xen/xen-ops.h>
> > >
> > > @@ -292,3 +293,36 @@ void __init xen_efi_runtime_setup(void)
> > >       efi.get_next_high_mono_count    =3D xen_efi_get_next_high_mono_=
count;
> > >       efi.reset_system                =3D xen_efi_reset_system;
> > >  }
> > > +
> > > +int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> > > +{
> > > +     static_assert(XEN_PAGE_SHIFT =3D=3D EFI_PAGE_SHIFT,
> > > +                   "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHI=
FT");
> > > +     struct xen_platform_op op =3D {
> > > +             .cmd =3D XENPF_firmware_info,
> > > +             .u.firmware_info =3D {
> > > +                     .type =3D XEN_FW_EFI_INFO,
> > > +                     .index =3D XEN_FW_EFI_MEM_INFO,
> > > +                     .u.efi_info.mem.addr =3D phys_addr,
> > > +                     .u.efi_info.mem.size =3D U64_MAX - phys_addr,
> > > +             }
> > > +     };
> > > +     union xenpf_efi_info *info =3D &op.u.firmware_info.u.efi_info;
> > > +     int rc;
> > > +
> > > +     if (!efi_enabled(EFI_PARAVIRT) || efi_enabled(EFI_MEMMAP))
> > > +             return __efi_mem_desc_lookup(phys_addr, out_md);
> > > +
> > > +     rc =3D HYPERVISOR_platform_op(&op);
> > > +     if (rc) {
> > > +             pr_warn("Failed to lookup header 0x%llx in Xen memory m=
ap: error %d\n",
> > > +                     phys_addr, rc);
> > > +     }
> > > +
> > > +     out_md->phys_addr       =3D info->mem.addr;
> >
> > This will be equal to phys_addr, not the actual start of the memory
> > region.
> >
> > > +     out_md->num_pages       =3D info->mem.size >> EFI_PAGE_SHIFT;
> >
> > Similarly, this will be the number of bytes in the memory region
> > after phys_addr, not the total number of bytes in the region.  These two
> > differences mean that this function is not strictly equivalent to the
> > original efi_mem_desc_lookup().
> >
> > I am not sure if this matters in practice, but I thought you would want
> > to be aware of it.
>=20
> This is a bit disappointing. Is there no way to obtain this
> information via a Xen hypercall?

It is possible, but doing so is very complex (it essentially requires a
binary search).  This really should be fixed on the Xen side.

> In any case, it means we'll need to round down phys_addr to page size
> at the very least.

That makes sense.  Are there any callers that will be broken even with
this rounding?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--t6nMBPUwd7mkm4Ai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM7DGEACgkQsoi1X/+c
IsHWbQ//bOkG2n0pJ/Y4g3ew+zBRIs12g+FI06XjMN9ih4aTF4ljax/VVJYwCv6N
064YbyhY0a4aUs/90iT2ZSliTo14dxMvCuCYgJ6Md7wkvgEbTb69Ga7bw9Yq2IRM
xEBDAf3h1djM7yG56A0ZOeD3A9XI6hYeAQv7we/4/tm5HLlQM+mdijycNOYNT4o8
o2SM6Or+f/veMAz95oFTX8uwd9MWWFOZL2pzFbEjI/yxzIzD0m8x7dFZOijXK3RD
zGbu4r3RVQdm3w4pxY/pGXNxUL9fadPln57ZVs13jpe1v0hyAQQpefBL6kOUoB1T
8uoRjtYpSOFkZEBYx8Dd+MwNcEtsE1lYUa8OlQTDL98qJROAc6k0wvHscm0B9ghO
yJXV7IMdWSSKebhYAuBi7d7nG9PzimqsuxRQEry2uLfP95dSjFpQ2dIh8I9qpKoh
SPQ4JNvoY5aJbU+tsmA/4+7l4Wc5GWeExgfn31CAz5nvy/512TCpBGLDu0O8wT9W
E8YqSACeLP/2SUI3UnWqihRCOti0cypN64EiWk3rKfSGPkG1KFIXa/Ywxk0Gg4lL
Z8DlvjONFbppE33cwzOixG7RC+ItmbHiJ0TnSzqhzdhB3IUf6NBmdJ60aNwA6c88
Y3frOLDCRXdpJDI6BAKKjH8xVVp2qkNf/DVMoNHDbMfohjhbE7I=
=YbWg
-----END PGP SIGNATURE-----

--t6nMBPUwd7mkm4Ai--
