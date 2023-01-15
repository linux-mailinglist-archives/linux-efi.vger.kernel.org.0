Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177266B144
	for <lists+linux-efi@lfdr.de>; Sun, 15 Jan 2023 14:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjAONbP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 15 Jan 2023 08:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjAONbO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 15 Jan 2023 08:31:14 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFE246A8
        for <linux-efi@vger.kernel.org>; Sun, 15 Jan 2023 05:31:11 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 674715C0062;
        Sun, 15 Jan 2023 08:31:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 15 Jan 2023 08:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1673789469; x=
        1673875869; bh=+SXSZ20hXLrjTTJOPMKMT76P9OAHK56Wb+bD0RGRY6A=; b=h
        Mi5o70zxeg2tr6OK0LM+gvqj2csyZ0UpZ4YHspmyA61iM5VCRwVYXQ3MhktJfNfi
        wId881BcTaEc8tkHi20OKscHjQHmgKg2CkDR1pM91KzrnF4++CJ1n71T63iYx8T4
        oFh98DlbpGbuH9rpKFub4nNGCAa37fyUicuywBNWq7YrRsViYPAoro3LKWKMEu7k
        nu5/+H7mRS/fSDegBG6pKJkzLjS6seXwWAehRFpwLpCxmRjNcz65+fg/Ri7hX5Ub
        JUtWZ2OonyTs52+fwy3xyLaSK9osMvMoBPZiYZaNTWU7sIK1YrOUTm8F+odKBRz3
        8muj+LFVBbciYWXneuAXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673789469; x=1673875869; bh=+SXSZ20hXLrjTTJOPMKMT76P9OAH
        K56Wb+bD0RGRY6A=; b=Y2MK6Hc2dieOOOMhdkaB7k0XCdOQlVPTn4wjwXtFcauE
        a9v9fvAiKh9R+nCaY3wxpOm3x/jB7VjXuzBB8KQPfn2OXwAgD5K/d2FiPAwKhfvJ
        hZEK36sPjIxi0/UIsyQEXaTVzJTXoLac99Krw3aru9ZgTs/gwUm4Gs3YswIoFF/e
        wnJ128ethOM4Zzd5x+yWzI/CC5XOwgvVAx/vldKD2qOOrQG7msbbrIkE6QrNzDeI
        3kbwhm+POXrK9Py64JdDDMntq9QpvsNCkdNWIgTlYypk71PXrZ4ranD8R8CvgYHv
        W3YV3hNrLOcOiZnAUSlrepTAz76QSe1/S48t0bPYHA==
X-ME-Sender: <xms:HADEYwsPHscSFtDF7wFn29G8FWS5IOKXWc3uyGMBE4S9kT44QeKrSw>
    <xme:HADEY9dlann9Llf38U-VoGzB8WlxOPj5T8Qx20MBsUJL9JEbeKx1j4W6cBP9zYjix
    B0QiyBFOnun7w>
X-ME-Received: <xmr:HADEY7zeYJUulTVSizoYiZQ3U-CMn3ERrUIotLqH67Ps6oWEDlAKVekG3ykMIke8bUgO_SRxHEfZ-JY7_JH3BD59HPhVBg9LMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtvddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgv
    khcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinh
    hvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepueek
    teetgefggfekudehteegieeljeejieeihfejgeevhfetgffgteeuteetueetnecuffhomh
    grihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhm
X-ME-Proxy: <xmx:HADEYzMqj0Ty7WfAMcyZ6RROAUQsyoQqnTNFY6C3wyuXytC9h1brVw>
    <xmx:HADEYw-OJi7H5ZgptihbzRMBEOqpBrxRXkhb-pO3gnxqAnIfSgpREg>
    <xmx:HADEY7WSxsIrLmfyhp7VTgQ2yIT3STCwcLcHovaL417im0X9QzmnTg>
    <xmx:HQDEY7Y93-IVKrVse5pErUp4l2AKFjCZ4Bd5Ng5tGX8_Mm6lz3BDzQ>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Jan 2023 08:31:07 -0500 (EST)
Date:   Sun, 15 Jan 2023 14:31:03 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
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
Message-ID: <Y8QAF5K4ZLJxzPni@mail-itl>
References: <20221003112625.972646-1-ardb@kernel.org>
 <20221003112625.972646-6-ardb@kernel.org>
 <Yzr/1s9CbA0CClmt@itl-email>
 <CAMj1kXEXhDXRSnBp8P=urFj8UzzeRtYS9V8Tdt9GSrZTnGRFhA@mail.gmail.com>
 <YzsMYfEwmjHwVheb@itl-email>
 <CAMj1kXHR1FfD+ipG4RtbOezx+s_Jo6JwG4fpT5XUmvoqHTctLA@mail.gmail.com>
 <YzsWAnD7q9qeBoBn@mail-itl>
 <Yzsii72GWWvc5tRD@itl-email>
 <YzsjYHirK+SXUjGl@mail-itl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Brnh0jZ4ScsEj+y3"
Content-Disposition: inline
In-Reply-To: <YzsjYHirK+SXUjGl@mail-itl>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--Brnh0jZ4ScsEj+y3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Jan 2023 14:31:03 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
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

On Mon, Oct 03, 2022 at 08:01:03PM +0200, Marek Marczykowski-G=C3=B3recki w=
rote:
> On Mon, Oct 03, 2022 at 01:57:14PM -0400, Demi Marie Obenour wrote:
> > On Mon, Oct 03, 2022 at 07:04:02PM +0200, Marek Marczykowski-G=C3=B3rec=
ki wrote:
> > > On Mon, Oct 03, 2022 at 06:37:19PM +0200, Ard Biesheuvel wrote:
> > > > On Mon, 3 Oct 2022 at 18:23, Demi Marie Obenour
> > > > <demi@invisiblethingslab.com> wrote:
> > > > >
> > > > > On Mon, Oct 03, 2022 at 05:59:52PM +0200, Ard Biesheuvel wrote:
> > > > > > On Mon, 3 Oct 2022 at 17:29, Demi Marie Obenour
> > > > > > <demi@invisiblethingslab.com> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 03, 2022 at 01:26:24PM +0200, Ard Biesheuvel wrot=
e:
> > > > > > > > Xen on x86 boots dom0 in EFI mode but without providing a m=
emory map.
> > > > > > > > This means that some sanity checks we would like to perform=
 on
> > > > > > > > configuration tables or other data structures in memory are=
 not
> > > > > > > > currently possible. Xen does, however, expose EFI memory de=
scriptor info
> > > > > > > > via a Xen hypercall, so let's wire that up instead.
> > > > > > > >
> > > > > > > > Co-developed-by: Demi Marie Obenour <demi@invisiblethingsla=
b.com>
> > > > > > > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.=
com>
> > > > > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > > > > ---
> > > > > > > >  drivers/firmware/efi/efi.c |  5 ++-
> > > > > > > >  drivers/xen/efi.c          | 34 ++++++++++++++++++++
> > > > > > > >  include/linux/efi.h        |  1 +
> > > > > > > >  3 files changed, 39 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/=
efi/efi.c
> > > > > > > > index 55bd3f4aab28..2c12b1a06481 100644
> > > > > > > > --- a/drivers/firmware/efi/efi.c
> > > > > > > > +++ b/drivers/firmware/efi/efi.c
> > > > > > > > @@ -456,7 +456,7 @@ void __init efi_find_mirror(void)
> > > > > > > >   * and if so, populate the supplied memory descriptor with=
 the appropriate
> > > > > > > >   * data.
> > > > > > > >   */
> > > > > > > > -int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *=
out_md)
> > > > > > > > +int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t=
 *out_md)
> > > > > > > >  {
> > > > > > > >       efi_memory_desc_t *md;
> > > > > > > >
> > > > > > > > @@ -485,6 +485,9 @@ int efi_mem_desc_lookup(u64 phys_addr, =
efi_memory_desc_t *out_md)
> > > > > > > >       return -ENOENT;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_d=
esc_t *out_md)
> > > > > > > > +      __weak __alias(__efi_mem_desc_lookup);
> > > > > > > > +
> > > > > > > >  /*
> > > > > > > >   * Calculate the highest address of an efi memory descript=
or.
> > > > > > > >   */
> > > > > > > > diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
> > > > > > > > index d1ff2186ebb4..74f3f6d8cdc8 100644
> > > > > > > > --- a/drivers/xen/efi.c
> > > > > > > > +++ b/drivers/xen/efi.c
> > > > > > > > @@ -26,6 +26,7 @@
> > > > > > > >
> > > > > > > >  #include <xen/interface/xen.h>
> > > > > > > >  #include <xen/interface/platform.h>
> > > > > > > > +#include <xen/page.h>
> > > > > > > >  #include <xen/xen.h>
> > > > > > > >  #include <xen/xen-ops.h>
> > > > > > > >
> > > > > > > > @@ -292,3 +293,36 @@ void __init xen_efi_runtime_setup(void)
> > > > > > > >       efi.get_next_high_mono_count    =3D xen_efi_get_next_=
high_mono_count;
> > > > > > > >       efi.reset_system                =3D xen_efi_reset_sys=
tem;
> > > > > > > >  }
> > > > > > > > +
> > > > > > > > +int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *=
out_md)
> > > > > > > > +{
> > > > > > > > +     static_assert(XEN_PAGE_SHIFT =3D=3D EFI_PAGE_SHIFT,
> > > > > > > > +                   "Mismatch between EFI_PAGE_SHIFT and XE=
N_PAGE_SHIFT");
> > > > > > > > +     struct xen_platform_op op =3D {
> > > > > > > > +             .cmd =3D XENPF_firmware_info,
> > > > > > > > +             .u.firmware_info =3D {
> > > > > > > > +                     .type =3D XEN_FW_EFI_INFO,
> > > > > > > > +                     .index =3D XEN_FW_EFI_MEM_INFO,
> > > > > > > > +                     .u.efi_info.mem.addr =3D phys_addr,
> > > > > > > > +                     .u.efi_info.mem.size =3D U64_MAX - ph=
ys_addr,
> > > > > > > > +             }
> > > > > > > > +     };
> > > > > > > > +     union xenpf_efi_info *info =3D &op.u.firmware_info.u.=
efi_info;
> > > > > > > > +     int rc;
> > > > > > > > +
> > > > > > > > +     if (!efi_enabled(EFI_PARAVIRT) || efi_enabled(EFI_MEM=
MAP))
> > > > > > > > +             return __efi_mem_desc_lookup(phys_addr, out_m=
d);
> > > > > > > > +
> > > > > > > > +     rc =3D HYPERVISOR_platform_op(&op);
> > > > > > > > +     if (rc) {
> > > > > > > > +             pr_warn("Failed to lookup header 0x%llx in Xe=
n memory map: error %d\n",
> > > > > > > > +                     phys_addr, rc);
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     out_md->phys_addr       =3D info->mem.addr;
> > > > > > >
> > > > > > > This will be equal to phys_addr, not the actual start of the =
memory
> > > > > > > region.
> > > > > > >
> > > > > > > > +     out_md->num_pages       =3D info->mem.size >> EFI_PAG=
E_SHIFT;
> > > > > > >
> > > > > > > Similarly, this will be the number of bytes in the memory reg=
ion
> > > > > > > after phys_addr, not the total number of bytes in the region.=
  These two
> > > > > > > differences mean that this function is not strictly equivalen=
t to the
> > > > > > > original efi_mem_desc_lookup().
> > > > > > >
> > > > > > > I am not sure if this matters in practice, but I thought you =
would want
> > > > > > > to be aware of it.
> > > > > >
> > > > > > This is a bit disappointing. Is there no way to obtain this
> > > > > > information via a Xen hypercall?
> > > > >
> > > > > It is possible, but doing so is very complex (it essentially requ=
ires a
> > > > > binary search).  This really should be fixed on the Xen side.
> > > > >
> > > > > > In any case, it means we'll need to round down phys_addr to pag=
e size
> > > > > > at the very least.
> > > > >
> > > > > That makes sense.  Are there any callers that will be broken even=
 with
> > > > > this rounding?
> > > >=20
> > > > As far as I can tell, it should work fine. The only thing to double
> > > > check is whether we are not creating spurious error messages from
> > > > efi_arch_mem_reserve() this way, but as far as I can tell, that sho=
uld
> > > > be fine too.
> > > >=20
> > > > Is there anyone at your end that can give this a spin on an actual
> > > > Xen/x86 system?
> > >=20
> > > Demi, if you open a PR with this at
> > > https://github.com/QubesOS/qubes-linux-kernel/pulls, I can run it
> > > through our CI - (at least) one of the machines has ESRT table. AFAIR
> > > your test laptop has it too.
> >=20
> > Just this patch or the whole series?
>=20
> Whole series.

I have tested the series as in
https://github.com/QubesOS/qubes-linux-kernel/pull/681 and it seems to
work great.
Note the series there differs from this thread, and is marked as "v3" - I
assume (but haven't verified) it has changes requested in this thread
applied. Demi, can you confirm? If so, you can probably send this v3,
and feel free to include my Tested-by (unless you make significant
changes, ofc).

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--Brnh0jZ4ScsEj+y3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmPEABcACgkQ24/THMrX
1yzidQf/fw6/BjJE0q8FQMmaZtoPGu8ikWosCRW2C8jXxcCr6Mygrhlu7Ddn6RBC
yBJmyuuvl5xEd3TS5h0Xd6iRE/DEQqIinE+FwLNejsNiQkiGIBDHCEJaFox6B2f4
NdXMzUYIXdIXarC5rhWIUO75Zbc61+H6MO6iuyEDhHtOlQ7QZTDvBH9/EevPNNeY
tHQqDhUkz7v9CczneoyqzAFADJXxLueIYD6sBdwEeVlNHMurS41DsLxRNuOV/ADf
e/3pYFOpvBYBWIj8NXTUoyBrNwU3NtE+Yj6cXbB7UQxSNa6TXc+lmZkntbQawPcQ
xJKIyGBbO/okzjrADNmJhkggn0OGiA==
=pAmZ
-----END PGP SIGNATURE-----

--Brnh0jZ4ScsEj+y3--
