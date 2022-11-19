Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85936308A8
	for <lists+linux-efi@lfdr.de>; Sat, 19 Nov 2022 02:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiKSBqS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Nov 2022 20:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiKSBp7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Nov 2022 20:45:59 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F249EC04
        for <linux-efi@vger.kernel.org>; Fri, 18 Nov 2022 17:10:45 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3562732005BC;
        Fri, 18 Nov 2022 20:10:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 18 Nov 2022 20:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668820240; x=
        1668906640; bh=5ZTgwin0129aHkVKnahjCMa8iAMdMUWn/8FuM88/l8s=; b=Y
        /kP2NAbHWWMuxtBzYGa+f7z0RUBou8a73WlsYgDTjXguRT0kLWMM5Gp8Qw6qwzy8
        ysLeF1gtK9fKJUX0cZrmCFGc+SyLVU22oiwRvpcRK2r/jywU7jbY6z2EmqezONAh
        DHqJk36+TrmMxla7hOeR/Rr5G0aFgaFNa7Hhw+3761ztHl1JWOgxo4xdezGUDsnM
        7O+5vz/ngBPkzIAz/MlPLWoCz52RX8RC+ZJv5HOWQGeKPsLx+cXkNS1IKki188NV
        xDtmLvLURwwJDrIC/8A/xetPJ/V41IADQKYyStoilVMHeI+jY5nb8I6FyDKyJp0B
        VfR1HwGzjTZ/8k7PNnF5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668820240; x=1668906640; bh=5ZTgwin0129aHkVKnahjCMa8iAMd
        MUWn/8FuM88/l8s=; b=A2qiiyNnB1jaLh+c3g0Bv2qIzo1xFA/STTCwKwGQhV8c
        CaQNuH8inrMNyUeDpesjwG4ZCt/STe/8bPr6H7gjsmRLAYmqf40smjpWrYKxabqg
        xRS6V/mBMQfsjKPJHumNqzUmzbobj2Sl8/VwJs0SYg0AGDhpQaVIyX0JaIf+fJJW
        jWk227NazmYUVG33QAImi1YYyyMsHifWAm0z6+t+Y3hUuyoy/Saqw17nTDJkdcSv
        gKj/yG8plOpQhmOE5GCHx7TmlzbVgNtCJhXWg+YhoEsJKX3LT808r9iqpeWLj4pb
        tOpceD1Nfm/RNRKr73YXXI4z3hXrM4BbJFnvizaRPQ==
X-ME-Sender: <xms:EC14Y280hcU5A1RrHFInJGG70pZJavb3XhdGRR93B959Pv2DB4akRQ>
    <xme:EC14Y2spHaf_CLDmV2FIoKAPYrtEUjqzqXAcnsjoTnXKXy5KlHbUZb9zeC157RzpU
    JvoY3BZ8zaxL4g>
X-ME-Received: <xmr:EC14Y8AcpUoF6n0cT3RGiRNnxW2iglnsjSSV1gSUVpd3nxwy798_V9jva6ky>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedugdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeeutdehhfdtvdfffeejjedvhedvjeei
    heffheekkeehgeelueelveeludetheetteenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggv
    mhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:EC14Y-cpBWb5QY20bmPxP62_-v4S90T2xWO1Bsk0dKMruX2kGTi0sw>
    <xmx:EC14Y7MlEEMBmIyOH-ID-cQ80NPTqW1QnIYzBon2JZrG_vZSMRnkkg>
    <xmx:EC14Y4l7qYuACqWRmp-f86ufzOf54CUohgu6JgWo1VjVrF4hGGpFJA>
    <xmx:EC14Y2qSZKvPN0cFz6r1znnh5Dh3ojE80Gf_FQDiHM6gO3YkMyktmQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 20:10:39 -0500 (EST)
Date:   Fri, 18 Nov 2022 20:10:33 -0500
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Xen developer discussion <xen-devel@lists.xenproject.org>,
        Peter Jones <pjones@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 5/6] efi: xen: Implement memory descriptor lookup
 based on hypercall
Message-ID: <Y3gtDS60csz03tjJ@itl-email>
References: <20221003112625.972646-1-ardb@kernel.org>
 <20221003112625.972646-6-ardb@kernel.org>
 <Yzr/1s9CbA0CClmt@itl-email>
 <CAMj1kXEXhDXRSnBp8P=urFj8UzzeRtYS9V8Tdt9GSrZTnGRFhA@mail.gmail.com>
 <YzsMYfEwmjHwVheb@itl-email>
 <CAMj1kXHR1FfD+ipG4RtbOezx+s_Jo6JwG4fpT5XUmvoqHTctLA@mail.gmail.com>
 <YzsWAnD7q9qeBoBn@mail-itl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eZXLIpVKxA42QWNq"
Content-Disposition: inline
In-Reply-To: <YzsWAnD7q9qeBoBn@mail-itl>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--eZXLIpVKxA42QWNq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Nov 2022 20:10:33 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	Xen developer discussion <xen-devel@lists.xenproject.org>,
	Peter Jones <pjones@redhat.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 5/6] efi: xen: Implement memory descriptor lookup
 based on hypercall

On Mon, Oct 03, 2022 at 07:04:02PM +0200, Marek Marczykowski-G=C3=B3recki w=
rote:
> On Mon, Oct 03, 2022 at 06:37:19PM +0200, Ard Biesheuvel wrote:
> > On Mon, 3 Oct 2022 at 18:23, Demi Marie Obenour
> > <demi@invisiblethingslab.com> wrote:
> > >
> > > On Mon, Oct 03, 2022 at 05:59:52PM +0200, Ard Biesheuvel wrote:
> > > > On Mon, 3 Oct 2022 at 17:29, Demi Marie Obenour
> > > > <demi@invisiblethingslab.com> wrote:
> > > > >
> > > > > On Mon, Oct 03, 2022 at 01:26:24PM +0200, Ard Biesheuvel wrote:
> > > > > > Xen on x86 boots dom0 in EFI mode but without providing a memor=
y map.
> > > > > > This means that some sanity checks we would like to perform on
> > > > > > configuration tables or other data structures in memory are not
> > > > > > currently possible. Xen does, however, expose EFI memory descri=
ptor info
> > > > > > via a Xen hypercall, so let's wire that up instead.
> > > > > >
> > > > > > Co-developed-by: Demi Marie Obenour <demi@invisiblethingslab.co=
m>
> > > > > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > > ---
> > > > > >  drivers/firmware/efi/efi.c |  5 ++-
> > > > > >  drivers/xen/efi.c          | 34 ++++++++++++++++++++
> > > > > >  include/linux/efi.h        |  1 +
> > > > > >  3 files changed, 39 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/=
efi.c
> > > > > > index 55bd3f4aab28..2c12b1a06481 100644
> > > > > > --- a/drivers/firmware/efi/efi.c
> > > > > > +++ b/drivers/firmware/efi/efi.c
> > > > > > @@ -456,7 +456,7 @@ void __init efi_find_mirror(void)
> > > > > >   * and if so, populate the supplied memory descriptor with the=
 appropriate
> > > > > >   * data.
> > > > > >   */
> > > > > > -int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_=
md)
> > > > > > +int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *ou=
t_md)
> > > > > >  {
> > > > > >       efi_memory_desc_t *md;
> > > > > >
> > > > > > @@ -485,6 +485,9 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_=
memory_desc_t *out_md)
> > > > > >       return -ENOENT;
> > > > > >  }
> > > > > >
> > > > > > +extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_=
t *out_md)
> > > > > > +      __weak __alias(__efi_mem_desc_lookup);
> > > > > > +
> > > > > >  /*
> > > > > >   * Calculate the highest address of an efi memory descriptor.
> > > > > >   */
> > > > > > diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
> > > > > > index d1ff2186ebb4..74f3f6d8cdc8 100644
> > > > > > --- a/drivers/xen/efi.c
> > > > > > +++ b/drivers/xen/efi.c
> > > > > > @@ -26,6 +26,7 @@
> > > > > >
> > > > > >  #include <xen/interface/xen.h>
> > > > > >  #include <xen/interface/platform.h>
> > > > > > +#include <xen/page.h>
> > > > > >  #include <xen/xen.h>
> > > > > >  #include <xen/xen-ops.h>
> > > > > >
> > > > > > @@ -292,3 +293,36 @@ void __init xen_efi_runtime_setup(void)
> > > > > >       efi.get_next_high_mono_count    =3D xen_efi_get_next_high=
_mono_count;
> > > > > >       efi.reset_system                =3D xen_efi_reset_system;
> > > > > >  }
> > > > > > +
> > > > > > +int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_=
md)
> > > > > > +{
> > > > > > +     static_assert(XEN_PAGE_SHIFT =3D=3D EFI_PAGE_SHIFT,
> > > > > > +                   "Mismatch between EFI_PAGE_SHIFT and XEN_PA=
GE_SHIFT");
> > > > > > +     struct xen_platform_op op =3D {
> > > > > > +             .cmd =3D XENPF_firmware_info,
> > > > > > +             .u.firmware_info =3D {
> > > > > > +                     .type =3D XEN_FW_EFI_INFO,
> > > > > > +                     .index =3D XEN_FW_EFI_MEM_INFO,
> > > > > > +                     .u.efi_info.mem.addr =3D phys_addr,
> > > > > > +                     .u.efi_info.mem.size =3D U64_MAX - phys_a=
ddr,
> > > > > > +             }
> > > > > > +     };
> > > > > > +     union xenpf_efi_info *info =3D &op.u.firmware_info.u.efi_=
info;
> > > > > > +     int rc;
> > > > > > +
> > > > > > +     if (!efi_enabled(EFI_PARAVIRT) || efi_enabled(EFI_MEMMAP))
> > > > > > +             return __efi_mem_desc_lookup(phys_addr, out_md);
> > > > > > +
> > > > > > +     rc =3D HYPERVISOR_platform_op(&op);
> > > > > > +     if (rc) {
> > > > > > +             pr_warn("Failed to lookup header 0x%llx in Xen me=
mory map: error %d\n",
> > > > > > +                     phys_addr, rc);
> > > > > > +     }
> > > > > > +
> > > > > > +     out_md->phys_addr       =3D info->mem.addr;
> > > > >
> > > > > This will be equal to phys_addr, not the actual start of the memo=
ry
> > > > > region.
> > > > >
> > > > > > +     out_md->num_pages       =3D info->mem.size >> EFI_PAGE_SH=
IFT;
> > > > >
> > > > > Similarly, this will be the number of bytes in the memory region
> > > > > after phys_addr, not the total number of bytes in the region.  Th=
ese two
> > > > > differences mean that this function is not strictly equivalent to=
 the
> > > > > original efi_mem_desc_lookup().
> > > > >
> > > > > I am not sure if this matters in practice, but I thought you woul=
d want
> > > > > to be aware of it.
> > > >
> > > > This is a bit disappointing. Is there no way to obtain this
> > > > information via a Xen hypercall?
> > >
> > > It is possible, but doing so is very complex (it essentially requires=
 a
> > > binary search).  This really should be fixed on the Xen side.
> > >
> > > > In any case, it means we'll need to round down phys_addr to page si=
ze
> > > > at the very least.
> > >
> > > That makes sense.  Are there any callers that will be broken even with
> > > this rounding?
> >=20
> > As far as I can tell, it should work fine. The only thing to double
> > check is whether we are not creating spurious error messages from
> > efi_arch_mem_reserve() this way, but as far as I can tell, that should
> > be fine too.
> >=20
> > Is there anyone at your end that can give this a spin on an actual
> > Xen/x86 system?
>=20
> Demi, if you open a PR with this at
> https://github.com/QubesOS/qubes-linux-kernel/pulls, I can run it
> through our CI - (at least) one of the machines has ESRT table.

Done: https://github.com/QubesOS/qubes-linux-kernel/pull/681

> AFAIR your test laptop has it too.

It does; I plan to test a version that has the needed rounding.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--eZXLIpVKxA42QWNq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmN4LQ4ACgkQsoi1X/+c
IsHajw//UHBxXvpBAaynVshK24kWcagS+15BbXEqlSvj8f4y7Kjd/j71nedJG9wM
fbDlTd9ThZh+Bts17ytNdVxxx1NPN0vwm9Y65alkMraBBS0zKlbSMLofYTBHc4K5
k9JxkuEejvWOYXKEHzDXIong/pKBMa1LFQVrkS/SfV8KpRm8jAS7+a/+5MnzsRP5
iAQ89uiCJO2fipRHlw7dEnwMy1UR7S/huHUaKh0Zjdyu3LGFNVkPC1LE43BVg8rB
2nwkfGpBcnHvGmG74/DC3SoPdlA89NCSaJnbJzY+0eEfkhZrZBaV4C7+MLCljXeQ
mDGyTDLYWpt5GKv52OfL1UmW1qlp2b1cn8mADcqAHFGKyWzhvsfV16J+q1p9eJ4f
xeX7PIYpHefhifjHnghR792HoVYaHrzz0fELsYlBCYxkysSzACpUbdgOXI3CJZ2u
nTuI+ktChEb9+EoV5ZF3RWzWjIQRLRZBkAXZdLuFn0+VKojnirSTf5UeBsqORStK
sNuHUirH2Y917nSidGZjAcMeh7wg1gA6nTx/zvfR+hoGZW7BUdlqbWUKHFyu8PqN
vlosBmJp16MCylNe61+1fxyM78dfpTMd72jHwJLyq71Na+WgiRXuCFUoADHCi6He
0KH4QOPfjJ0xYOokeSnC/6MNGIBYJdUaxxKUGgdQKSZ5emLd5WI=
=ahFb
-----END PGP SIGNATURE-----

--eZXLIpVKxA42QWNq--
