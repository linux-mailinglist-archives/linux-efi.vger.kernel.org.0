Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58D35F327E
	for <lists+linux-efi@lfdr.de>; Mon,  3 Oct 2022 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJCP3d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Oct 2022 11:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJCP3c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Oct 2022 11:29:32 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93FB6410
        for <linux-efi@vger.kernel.org>; Mon,  3 Oct 2022 08:29:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8F667320093C;
        Mon,  3 Oct 2022 11:29:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 03 Oct 2022 11:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664810969; x=
        1664897369; bh=wG2UKFKUqQSuw+UKGoNFakaJTVCzILWNxG1VAloni50=; b=R
        vkhz5Z4OWL2o1RQheGBXMSCgIKsLpV/sIeJE7oVs70pGN7HvbooHhrW76evaeOwm
        BOBs1S8JwFGhbFDZIUwYgLQ7u1J5+yhva2r0TdzVlXODf4J2NZqd0GQ+YyikEQ4H
        aZfRjSN+UJvVSdAwDsSYxvlf4oSrf4vMGfRKhTMoRsAGM0wojLqMwlg2pp6p1oZX
        LRUW5DAqo9rjPvThZuRY4Dyju//fcB5IMYTCqDtGBxlXZfYydt4e7CXxQ19JXmGG
        XFhNcKzNjIXtrNcYdxdytDRSZQ+257t0nfj8NeE4h4AYZswRtTWfq10XFQ1uEfvd
        VfWvWC0g+EZlNbpJ45i8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664810969; x=1664897369; bh=wG2UKFKUqQSuw+UKGoNFakaJTVCz
        ILWNxG1VAloni50=; b=hCro7hdOVhZFbKkbMuLxf2veLrel6GzkmLgJDtfpnowE
        Vfq6wpZAvxpC0hGzmnWl33ELsf8/Bsr0J1UnhePN+4GlTlbsIxFYKxrd0Ov1hjCG
        GlKEd28TZWjnpTer4mJSL0IhKXNrp/+JC73bcPtVBtvsOxJmkzbZFApqHaN790cy
        k70lbyp/zhO90puuSjkGIeXJsYMf4oh6p1ZeIjhe7qsriThezWR1z8EU/572rbbj
        +QBUZraJlKelf/AZPLyIK79j35t9zgi1AQ++uuvOqY7WXbKPHsu5u6Vp5wDVtqzk
        GnJpZrcyj3couu2alRgG3n3HbpyIH0/0LnPLkEjAdQ==
X-ME-Sender: <xms:2P86Y9mikPGuNdC5YzGQSE0SgnQjW2-JzXiksOpbEQw1SyfBz31ccw>
    <xme:2P86Y41o5mKQ7aEmD8-0SCI3D6_2x3v61_rt_JXkLQrIoiCqsTiY_iiPAh0b4cqA3
    icrualvUymqb_k>
X-ME-Received: <xmr:2P86YzqKZb3wW3PyEgcrDkbRyIZsXJGVo2xud296gByrPTIKDCrIUcLCkVAz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehledgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeileefueetvdelheeuteffjeeg
    jeegffekleevueelueekjeejudffteejkeetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:2P86Y9lix9xFS71wtW7P_Nm9Qk2RgLybs_fkjrtg8BepCrfyLU68jA>
    <xmx:2P86Y73QA64X64NYjuaRBc_HfzZDz5bA79myIKq4hv64jWaNXZlr1A>
    <xmx:2P86Y8tKTFrzW7apbeuIrclxjqjvu4pQEeuGzpOmm4gXG3PjttiEYQ>
    <xmx:2f86Y0sMpDzZVSvj9ZLf2H6wVcnLMO4Z7kESFOjws_Zh9QScMDOllg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Oct 2022 11:29:28 -0400 (EDT)
Date:   Mon, 3 Oct 2022 11:29:22 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Xen developer discussion <xen-devel@lists.xenproject.org>
Cc:     xen-devel@lists.xenproject.org, Peter Jones <pjones@redhat.com>,
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
Message-ID: <Yzr/1s9CbA0CClmt@itl-email>
References: <20221003112625.972646-1-ardb@kernel.org>
 <20221003112625.972646-6-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zLmjlM2QchXxvY8s"
Content-Disposition: inline
In-Reply-To: <20221003112625.972646-6-ardb@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--zLmjlM2QchXxvY8s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 3 Oct 2022 11:29:22 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	Xen developer discussion <xen-devel@lists.xenproject.org>
Cc: xen-devel@lists.xenproject.org, Peter Jones <pjones@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH v2 5/6] efi: xen: Implement memory descriptor lookup
 based on hypercall

On Mon, Oct 03, 2022 at 01:26:24PM +0200, Ard Biesheuvel wrote:
> Xen on x86 boots dom0 in EFI mode but without providing a memory map.
> This means that some sanity checks we would like to perform on
> configuration tables or other data structures in memory are not
> currently possible. Xen does, however, expose EFI memory descriptor info
> via a Xen hypercall, so let's wire that up instead.
>=20
> Co-developed-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/efi.c |  5 ++-
>  drivers/xen/efi.c          | 34 ++++++++++++++++++++
>  include/linux/efi.h        |  1 +
>  3 files changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 55bd3f4aab28..2c12b1a06481 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -456,7 +456,7 @@ void __init efi_find_mirror(void)
>   * and if so, populate the supplied memory descriptor with the appropria=
te
>   * data.
>   */
> -int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> +int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
>  {
>  	efi_memory_desc_t *md;
> =20
> @@ -485,6 +485,9 @@ int efi_mem_desc_lookup(u64 phys_addr, efi_memory_des=
c_t *out_md)
>  	return -ENOENT;
>  }
> =20
> +extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> +	 __weak __alias(__efi_mem_desc_lookup);
> +
>  /*
>   * Calculate the highest address of an efi memory descriptor.
>   */
> diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
> index d1ff2186ebb4..74f3f6d8cdc8 100644
> --- a/drivers/xen/efi.c
> +++ b/drivers/xen/efi.c
> @@ -26,6 +26,7 @@
> =20
>  #include <xen/interface/xen.h>
>  #include <xen/interface/platform.h>
> +#include <xen/page.h>
>  #include <xen/xen.h>
>  #include <xen/xen-ops.h>
> =20
> @@ -292,3 +293,36 @@ void __init xen_efi_runtime_setup(void)
>  	efi.get_next_high_mono_count	=3D xen_efi_get_next_high_mono_count;
>  	efi.reset_system		=3D xen_efi_reset_system;
>  }
> +
> +int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
> +{
> +	static_assert(XEN_PAGE_SHIFT =3D=3D EFI_PAGE_SHIFT,
> +		      "Mismatch between EFI_PAGE_SHIFT and XEN_PAGE_SHIFT");
> +	struct xen_platform_op op =3D {
> +		.cmd =3D XENPF_firmware_info,
> +		.u.firmware_info =3D {
> +			.type =3D XEN_FW_EFI_INFO,
> +			.index =3D XEN_FW_EFI_MEM_INFO,
> +			.u.efi_info.mem.addr =3D phys_addr,
> +			.u.efi_info.mem.size =3D U64_MAX - phys_addr,
> +		}
> +	};
> +	union xenpf_efi_info *info =3D &op.u.firmware_info.u.efi_info;
> +	int rc;
> +
> +	if (!efi_enabled(EFI_PARAVIRT) || efi_enabled(EFI_MEMMAP))
> +		return __efi_mem_desc_lookup(phys_addr, out_md);
> +
> +	rc =3D HYPERVISOR_platform_op(&op);
> +	if (rc) {
> +		pr_warn("Failed to lookup header 0x%llx in Xen memory map: error %d\n",
> +			phys_addr, rc);
> +	}
> +
> +	out_md->phys_addr	=3D info->mem.addr;

This will be equal to phys_addr, not the actual start of the memory
region.

> +	out_md->num_pages	=3D info->mem.size >> EFI_PAGE_SHIFT;

Similarly, this will be the number of bytes in the memory region
after phys_addr, not the total number of bytes in the region.  These two
differences mean that this function is not strictly equivalent to the
original efi_mem_desc_lookup().

I am not sure if this matters in practice, but I thought you would want
to be aware of it.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--zLmjlM2QchXxvY8s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM6/9UACgkQsoi1X/+c
IsHMOhAA333zIIHGob9IRTKkPT5IATDtd4wbALXjdQHsN3w7QV6STKKKkFY814ox
IvP7PMuPnRRZqHryNQLEtEYma41/clUZrBGxBcormyIUe2MJS9ZhZ0CZeUfWIlBA
V9yoKbmix0lfTxJaVuKtqc7BV20hARD0Uc5kxqZqJJ9WBJKtgxijBuaMkqXXYL1q
zRKFfyME35rcTYbBrjXFuiyJxfcSIIF9SWusd683vRLyUVaQafs8SpClc7A+zhCW
tRVnZ8jkPoKYVyBcalq+lxisCQiVuxio5HweNGqpEAM7gfhiqnfUw1orMEGzd1JK
LAza+q/6RbFL1q10zlvm7aL7xypiRgATef2wKY5jK0MqbYOGCBf2G5g9GDWOWZCL
a5r3rqmUXNIYaDYFm7myL9L5/+jtaORUDxzTexNa/7T1su9WCoXLe4eHZwl5zuYK
PTqn2bO5tUrRnCDBNSM2BAFkkUPX/9P3umM/iRauUuRGZER48mmwbImLx4H0lQ3v
IUARS3Jy8eliuI0fPxAUhY1RguxnhSUgxlAol+hcrE+92fFzKXSFRWb9iBz0xlAk
nD1uwI+geDIVE2NDm3IO3j4RqOSGl6BZnpmTxQrMBx7Vy9SFCMVYr3c0VU3zlsFw
/UJnOIEZhGlEdEucnYq8uNZbx8adJxD/9E8s0wLWZaKgRYUt60s=
=O4Xp
-----END PGP SIGNATURE-----

--zLmjlM2QchXxvY8s--
