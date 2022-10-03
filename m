Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C29F5F351E
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJCSBN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 14:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJCSBL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 14:01:11 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87BC15FDA
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 11:01:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C0B75C00CC;
        Mon,  3 Oct 2022 14:01:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 03 Oct 2022 14:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664820069; x=
        1664906469; bh=2VSQgyZMh4OrLebIIZol71KsbLOTruVueA8S4D6AtAM=; b=x
        ITHDnPmTc3sXy1/YEGBc0/zMMWHkn+C2RfVLlnqBmWieGW3G5ecdHMEp+XKQbeFV
        ePt3gcKnXLJ4ZfbANYSFgLisrrQB0NETOaV9DkkZ6EhNGj3yuoTmQZ7rit6k4rZy
        6TRfptJwXO3VuAs8olu2S8im+Y55N9v7TNHxGJsmpz5Fp9tZkGl9OiVvJr0JopkY
        TRwdsKxV4UAUe3SJ0tO3woADAwsyygMjATKauinIqGHALdsMnAZqVJF37bYXMpx0
        lg/sUeT+Qg+YVib40Byv1DfjODewcd+tNvkPke7LXBNyIFyjKiW3rwLSdqR/V16K
        +jjFhIpMpNQB8geWk2zXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664820069; x=1664906469; bh=2VSQgyZMh4OrLebIIZol71KsbLOT
        ruVueA8S4D6AtAM=; b=SdsXrNzPkeO1eknmVarRpbhC8j5X7JDsrmu/7W15ARDm
        Db2vyLq4jN/1SJtjWk6pA3IUAnBTEfqyKS15Qf+g6VyDvJ+fP7EY1iwanbxORGSt
        JPiAK6tuOlqDhxdRY0577EW149/QMX8aQ3hb/oShIH3GQkTdrh113L1e4gkY2CTX
        hdvQ346KEbvws5/51NncAVIWc6RGlkhWivv+m5mCPL78fWn5vV+A+ro/lNVAl/64
        42lOvw3s0kUyt53YmjSDRs0y+zyRl9qtrj1rmEgAIWCxYqoWyD2tOxt9PHy8xby8
        lWYOtMfuZXdzaXFHeAOqR2h5rOqOtiPCB3mo0I1NGw==
X-ME-Sender: <xms:ZCM7Y5QFe5xFLeF13L0geUYgNtEc3x6m1BkNghhmwM09luuY5GGshw>
    <xme:ZCM7Yyx0yutZ05N8-CktogFeRCanL3-UPEHiwlQ25SmlPqz7pPFN4PQJsH7JSwxJw
    hgBal4pHnam-Q>
X-ME-Received: <xmr:ZCM7Y-1Wg4HLu-l5bhAZZqjwdtnhXz9J7gGNj5jrVcAOM0nj8_jhzdRkKN6RUw4XWbIgznEcfYpcZBWAkC208Ptwip0IyjPhgFWC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghr
    vghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesih
    hnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeeu
    keetteeggffgkeduheetgeeileejjeeiiefhjeegvefhtefggfetueetteeuteenucffoh
    hmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomh
X-ME-Proxy: <xmx:ZCM7YxBdZBIgrfXxapZ1K3ZTr9-ynle6zpQZRHb8SeOR52Awjvx8Sw>
    <xmx:ZCM7YyjEW-dkd8KkJD8_u5mF1usamyCAQNFVUDaapFAtus3IobuYrQ>
    <xmx:ZCM7Y1oRFfpCKEyzzfirXGaHhc2UN_7PfIK4S4Ut6Dfv1SKqYnp7YA>
    <xmx:ZSM7Y9PhirwJuAPtKJPLrIZSk2vN-jZANn0vDbtIFODJ3iFUsXQnHw>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Oct 2022 14:01:07 -0400 (EDT)
Date:   Mon, 3 Oct 2022 20:01:03 +0200
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
Message-ID: <YzsjYHirK+SXUjGl@mail-itl>
References: <20221003112625.972646-1-ardb@kernel.org>
 <20221003112625.972646-6-ardb@kernel.org>
 <Yzr/1s9CbA0CClmt@itl-email>
 <CAMj1kXEXhDXRSnBp8P=urFj8UzzeRtYS9V8Tdt9GSrZTnGRFhA@mail.gmail.com>
 <YzsMYfEwmjHwVheb@itl-email>
 <CAMj1kXHR1FfD+ipG4RtbOezx+s_Jo6JwG4fpT5XUmvoqHTctLA@mail.gmail.com>
 <YzsWAnD7q9qeBoBn@mail-itl>
 <Yzsii72GWWvc5tRD@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="on5cRYSDowX0FpPJ"
Content-Disposition: inline
In-Reply-To: <Yzsii72GWWvc5tRD@itl-email>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--on5cRYSDowX0FpPJ
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 3 Oct 2022 20:01:03 +0200
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

On Mon, Oct 03, 2022 at 01:57:14PM -0400, Demi Marie Obenour wrote:
> On Mon, Oct 03, 2022 at 07:04:02PM +0200, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > On Mon, Oct 03, 2022 at 06:37:19PM +0200, Ard Biesheuvel wrote:
> > > On Mon, 3 Oct 2022 at 18:23, Demi Marie Obenour
> > > <demi@invisiblethingslab.com> wrote:
> > > >
> > > > On Mon, Oct 03, 2022 at 05:59:52PM +0200, Ard Biesheuvel wrote:
> > > > > On Mon, 3 Oct 2022 at 17:29, Demi Marie Obenour
> > > > > <demi@invisiblethingslab.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 03, 2022 at 01:26:24PM +0200, Ard Biesheuvel wrote:
> > > > > > > Xen on x86 boots dom0 in EFI mode but without providing a mem=
ory map.
> > > > > > > This means that some sanity checks we would like to perform on
> > > > > > > configuration tables or other data structures in memory are n=
ot
> > > > > > > currently possible. Xen does, however, expose EFI memory desc=
riptor info
> > > > > > > via a Xen hypercall, so let's wire that up instead.
> > > > > > >
> > > > > > > Co-developed-by: Demi Marie Obenour <demi@invisiblethingslab.=
com>
> > > > > > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.co=
m>
> > > > > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > > > ---
> > > > > > >  drivers/firmware/efi/efi.c |  5 ++-
> > > > > > >  drivers/xen/efi.c          | 34 ++++++++++++++++++++
> > > > > > >  include/linux/efi.h        |  1 +
> > > > > > >  3 files changed, 39 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/ef=
i/efi.c
> > > > > > > index 55bd3f4aab28..2c12b1a06481 100644
> > > > > > > --- a/drivers/firmware/efi/efi.c
> > > > > > > +++ b/drivers/firmware/efi/efi.c
> > > > > > > @@ -456,7 +456,7 @@ void __init efi_find_mirror(void)
> > > > > > >   * and if so, populate the supplied memory descriptor with t=
he appropriate
> > > > > > >   * data.
> > > > > > >   */
> > > > > > > -int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *ou=
t_md)
> > > > > > > +int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *=
out_md)
> > > > > > >  {
> > > > > > >       efi_memory_desc_t *md;
> > > > > > >
> > > > > > > @@ -485,6 +485,9 @@ int efi_mem_desc_lookup(u64 phys_addr, ef=
i_memory_desc_t *out_md)
> > > > > > >       return -ENOENT;
> > > > > > >  }
> > > > > > >
> > > > > > > +extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_des=
c_t *out_md)
> > > > > > > +      __weak __alias(__efi_mem_desc_lookup);
> > > > > > > +
> > > > > > >  /*
> > > > > > >   * Calculate the highest address of an efi memory descriptor.
> > > > > > >   */
> > > > > > > diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
> > > > > > > index d1ff2186ebb4..74f3f6d8cdc8 100644
> > > > > > > --- a/drivers/xen/efi.c
> > > > > > > +++ b/drivers/xen/efi.c
> > > > > > > @@ -26,6 +26,7 @@
> > > > > > >
> > > > > > >  #include <xen/interface/xen.h>
> > > > > > >  #include <xen/interface/platform.h>
> > > > > > > +#include <xen/page.h>
> > > > > > >  #include <xen/xen.h>
> > > > > > >  #include <xen/xen-ops.h>
> > > > > > >
> > > > > > > @@ -292,3 +293,36 @@ void __init xen_efi_runtime_setup(void)
> > > > > > >       efi.get_next_high_mono_count    =3D xen_efi_get_next_hi=
gh_mono_count;
> > > > > > >       efi.reset_system                =3D xen_efi_reset_syste=
m;
> > > > > > >  }
> > > > > > > +
> > > > > > > +int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *ou=
t_md)
> > > > > > > +{
> > > > > > > +     static_assert(XEN_PAGE_SHIFT =3D=3D EFI_PAGE_SHIFT,
> > > > > > > +                   "Mismatch between EFI_PAGE_SHIFT and XEN_=
PAGE_SHIFT");
> > > > > > > +     struct xen_platform_op op =3D {
> > > > > > > +             .cmd =3D XENPF_firmware_info,
> > > > > > > +             .u.firmware_info =3D {
> > > > > > > +                     .type =3D XEN_FW_EFI_INFO,
> > > > > > > +                     .index =3D XEN_FW_EFI_MEM_INFO,
> > > > > > > +                     .u.efi_info.mem.addr =3D phys_addr,
> > > > > > > +                     .u.efi_info.mem.size =3D U64_MAX - phys=
_addr,
> > > > > > > +             }
> > > > > > > +     };
> > > > > > > +     union xenpf_efi_info *info =3D &op.u.firmware_info.u.ef=
i_info;
> > > > > > > +     int rc;
> > > > > > > +
> > > > > > > +     if (!efi_enabled(EFI_PARAVIRT) || efi_enabled(EFI_MEMMA=
P))
> > > > > > > +             return __efi_mem_desc_lookup(phys_addr, out_md);
> > > > > > > +
> > > > > > > +     rc =3D HYPERVISOR_platform_op(&op);
> > > > > > > +     if (rc) {
> > > > > > > +             pr_warn("Failed to lookup header 0x%llx in Xen =
memory map: error %d\n",
> > > > > > > +                     phys_addr, rc);
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     out_md->phys_addr       =3D info->mem.addr;
> > > > > >
> > > > > > This will be equal to phys_addr, not the actual start of the me=
mory
> > > > > > region.
> > > > > >
> > > > > > > +     out_md->num_pages       =3D info->mem.size >> EFI_PAGE_=
SHIFT;
> > > > > >
> > > > > > Similarly, this will be the number of bytes in the memory region
> > > > > > after phys_addr, not the total number of bytes in the region.  =
These two
> > > > > > differences mean that this function is not strictly equivalent =
to the
> > > > > > original efi_mem_desc_lookup().
> > > > > >
> > > > > > I am not sure if this matters in practice, but I thought you wo=
uld want
> > > > > > to be aware of it.
> > > > >
> > > > > This is a bit disappointing. Is there no way to obtain this
> > > > > information via a Xen hypercall?
> > > >
> > > > It is possible, but doing so is very complex (it essentially requir=
es a
> > > > binary search).  This really should be fixed on the Xen side.
> > > >
> > > > > In any case, it means we'll need to round down phys_addr to page =
size
> > > > > at the very least.
> > > >
> > > > That makes sense.  Are there any callers that will be broken even w=
ith
> > > > this rounding?
> > >=20
> > > As far as I can tell, it should work fine. The only thing to double
> > > check is whether we are not creating spurious error messages from
> > > efi_arch_mem_reserve() this way, but as far as I can tell, that should
> > > be fine too.
> > >=20
> > > Is there anyone at your end that can give this a spin on an actual
> > > Xen/x86 system?
> >=20
> > Demi, if you open a PR with this at
> > https://github.com/QubesOS/qubes-linux-kernel/pulls, I can run it
> > through our CI - (at least) one of the machines has ESRT table. AFAIR
> > your test laptop has it too.
>=20
> Just this patch or the whole series?

Whole series.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--on5cRYSDowX0FpPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmM7I2AACgkQ24/THMrX
1yzg/wf+LDFTPPUw1J/CQtZxhhVNBN8dSU3exFs5qVg5GCNO4KPA1pyN1SnRbmOY
ofZvTP4SqCqnS+la1l4Afk4DS1DyV5jxAFbfmhIiSuh8283W3U1yUQ3JvBQVZWAf
Zj2Rsh8la2rIzx6vg3cMNPp7JgOc7AP0EC9xuU6MWpro20WE1TXgP1NTem2Z5h35
k4a0YQtiJj5RL0rXfg7Wnh8O1IVdvVwy4iov32zIJpBFeX/2o9YtQyeRY+S5nJwU
/i84JaQHvgqXXktgkZK/AiJvQ3YooH4oE/rHSL3YNI9TgFRZAQTcG3Zkqh59bj2Q
EuPbN4UMkuOF29tgFSIGrTEMoKehPA==
=C5Oy
-----END PGP SIGNATURE-----

--on5cRYSDowX0FpPJ--
