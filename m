Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1161B5F350F
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 19:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJCR7L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 13:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJCR6c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 13:58:32 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6D7E9C
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 10:57:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5D6E8320046E;
        Mon,  3 Oct 2022 13:57:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Oct 2022 13:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664819853; x=
        1664906253; bh=Uk/JRNKVFvl3lheGUgcaqE6S3hAEYs1iJ28X3bgK3n8=; b=v
        VsZ6jp3VA92awIcdhJ9PTNw6fvL/hCQrz+zKihzZNiT4f8b6d/9sqLjZGF3hTwVP
        hJ6jESee2bTlVQIZ0qC3KNP+WZXQ7yBFqamZTgzOchuO6m6M5TBmvIMlSBr6JECb
        MiKKbvljhRIMO/btz9fsyAkTbTmUqnOAHpmWNaVJDg+l8ADCZ/RcGCC2uFP9jzW0
        /UuORFj8FA9wkuSuinH4ybMP5QLeBpQQyo2zQKe1X6zMvQHfhGOOW4LttDoHa/nC
        fQur4BNYkbr2YahBQFg9IrJE0mD6yHXk9wQ24Cbz45zaFaFiNjGxCq4OR0jUC2dx
        ycK35EQXEjNDss7ZKUbAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664819853; x=1664906253; bh=Uk/JRNKVFvl3lheGUgcaqE6S3hAE
        Ys1iJ28X3bgK3n8=; b=yoYyCvHKkCJV189oBA43bvso1jF8GXKr+6BcpSfL3VRG
        EN7Jxq4Hm4HUyeJhL/g3mkp8Xs6BK5zv4ZNN/tTFF18t++QS7D2Q4MOvpI/QkVwq
        u8h+TPRGab9rpYLnyivPAX1NFibDfVk7zwvVY2F3uL7dpR20wbwpOwdXesg6Oc1q
        FPSI2xNaWnK6ryITWNgjQT5mxfPoMS6iiRjKX+aG+uCHaTUnASDLI52p9FOZOVCX
        G26li60U/V8zI7QrVUtXh6SBVV2fkfHIUIlo2VxqIYIAF2Lj6aALDXosKViuXZ+l
        0CL6/L+knMFTS2bjIJcyrDiZpqM4QbLSuEXvCa5ekA==
X-ME-Sender: <xms:jSI7YyEmEDcduJE7-9NopEmf5dzANTzdQxgKLk9P-x1NMxd9Ll4enQ>
    <xme:jSI7YzX-gwDz4kPrk6CB-waMdBbCFvoCPI9onw7QionLHzYadPVlyLZjWawG2ME8y
    1l6II-JtYerpP4>
X-ME-Received: <xmr:jSI7Y8Iy0xQrJ_XVcrzP69dOktL_hAGnHoEZeZ_XL8os8yylvpdUvIsdC5Xm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeeutdehhfdtvdfffeejjedvhedv
    jeeiheffheekkeehgeelueelveeludetheetteenucffohhmrghinhepghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    uggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:jSI7Y8FUQumGyg9Xl3-mR1nd3rORIRdob-LgZt0P9ehCK8RL-cAHxg>
    <xmx:jSI7Y4VAk6UnmVXDl-InNEqHvxlJrJFQ3IHGpQA8eZqVQwl0o1nMZQ>
    <xmx:jSI7Y_OSLB1qmANyx3az7cqcdhhHX0tgCe-y252bD65gAcU9gir6uA>
    <xmx:jSI7Y8QnCqPqIP1n-gCnwpDXwhuwo8Wuu7UdCaT5_Epj08T5OLs36Q>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Oct 2022 13:57:32 -0400 (EDT)
Date:   Mon, 3 Oct 2022 13:57:14 -0400
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
Message-ID: <Yzsii72GWWvc5tRD@itl-email>
References: <20221003112625.972646-1-ardb@kernel.org>
 <20221003112625.972646-6-ardb@kernel.org>
 <Yzr/1s9CbA0CClmt@itl-email>
 <CAMj1kXEXhDXRSnBp8P=urFj8UzzeRtYS9V8Tdt9GSrZTnGRFhA@mail.gmail.com>
 <YzsMYfEwmjHwVheb@itl-email>
 <CAMj1kXHR1FfD+ipG4RtbOezx+s_Jo6JwG4fpT5XUmvoqHTctLA@mail.gmail.com>
 <YzsWAnD7q9qeBoBn@mail-itl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D2tRnVa6ooTGAsFd"
Content-Disposition: inline
In-Reply-To: <YzsWAnD7q9qeBoBn@mail-itl>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--D2tRnVa6ooTGAsFd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 3 Oct 2022 13:57:14 -0400
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
> through our CI - (at least) one of the machines has ESRT table. AFAIR
> your test laptop has it too.

Just this patch or the whole series?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--D2tRnVa6ooTGAsFd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM7IosACgkQsoi1X/+c
IsHF8g//dTIfIpadNIEXyA0aIp/PCyaEEQFoYaRj8IWhdimW3HpqcRPY0jxHTZUo
qAvAvWcKMluErnJG/DO+yVHaeGEV05kWlpG0tJXRN752l5pM8KVHLgIyXMVSEB3S
vMeBmXNAi+1mn/sgJ2dOIwWtkcdSumz8LZJc9t9gyP8cHkxmP/EKwstEuJvFZ9zA
ni8NM3H+wuOx5DDJia/3x4QSQrTrm4hG3Mea0owkgigs4RdjVzgYwnpEpeQjCyvQ
JUGh9IrdyXkvQxlRyblCY7NIRvAgYmilZZb2WP6wFB4AkGx5LqVxjmTEHUUurSe1
/gT7tNQz8ExioWIGgJyojoAXMtrazPKoUaPTWwQuZ9vIXsiWJYlaSOcXqFJlWUG1
R7HyZq05VR9iwKcqdofpv3UmMt0MPpQ4AXO9Tu7vFc3wrCv1K2FkXk1AXX09y4xd
ptV4Afr1eIdHlfZ3/YsPW6JNIyS1/DiTGywd4fkw2lIXOGP8O/BljbrSq/ZNwA/P
rgi8ABA2yr7iMUGbxP4RTJTLVZa9eL0xBRcF5400UxP77gLteC+wywqyvbvUqw9p
5v0Cn35/A37KMsm59mF4cMjr9NH5Zbj1fX3yYAkyrW7/G6bR4IaC6lacmLDurTKQ
SSJIexQAZMBxnsYpkq8T3PRAE2gDfPmPZ4tFEuDmHkxAdVilN+w=
=sgHR
-----END PGP SIGNATURE-----

--D2tRnVa6ooTGAsFd--
