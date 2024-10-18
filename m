Return-Path: <linux-efi+bounces-2007-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465239A3425
	for <lists+linux-efi@lfdr.de>; Fri, 18 Oct 2024 07:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040AD283286
	for <lists+linux-efi@lfdr.de>; Fri, 18 Oct 2024 05:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9C117AE1C;
	Fri, 18 Oct 2024 05:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b="0XL4uJ+k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EYArA03h"
X-Original-To: linux-efi@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906217332C;
	Fri, 18 Oct 2024 05:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729228912; cv=none; b=AVxAPuPdnarL9VEgqG919DheYpCxN2cOGPHVTsI96YDwJb2pJKeTXWhhEBlyDVNB0O9SjEbfXEWHtGAxlL8sluYq0F/j1MvOddA7BKEROSdmd+RwBLDWG584tHoLebDQ9BGAiJdlUVWX3EQzKYYfNyS3bc4i037quS3h3kZ9fKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729228912; c=relaxed/simple;
	bh=77CDYYll5IUCmbYzAvTtf6hWlCj10t9eqfPT2/u09VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfDqDXCzzVxVdL/lK+7wBGPcRlXOqhWFXOmlqdSVR1CDT4KlXFu/M7K0C9wz7PTQu/n+806nOVLFwdnXQzPj3qZKA9t2FCG92pkzbHiPvCDyFUCGh4ZKM8hGePnDRxdGOW6a3ncmeSBsWiGE09YaDCZg9b+jZuzfEkh26FjR7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net; spf=pass smtp.mailfrom=benboeckel.net; dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b=0XL4uJ+k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EYArA03h; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benboeckel.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 9AD7720046C;
	Fri, 18 Oct 2024 01:21:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 18 Oct 2024 01:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1729228908; x=1729236108; bh=Nv5e9PalN9ehiEsD+yPrlMtTklPaAwWS
	SEMCc1ilrnk=; b=0XL4uJ+k5BRpB5y1IoE4M6xl0EtkfdgI53rpppIgx01A4Y6Z
	+fFg3dHZxR1Wdzkbe5RdneosRJ14mU7yG3z5YFbYa6oKFUjVhVe/sVN75SKSPsge
	0YZTbsR2uyPF64EP28ekQ6narypVZUOkp47eIBEg1UNHbLfcN+ZQyVwwL+3B5wWW
	slOhgYtFeKqXY084zDXf2La9ZC7byXYaWtEK00YbPFLd1FMDodR1DOXjMMjF7bru
	lSZPd5YvNZ02TjYqE100BPSWZEvWzTGU9Ar1Pdv6Zg5VL5nX4iaXs+XqRRBl2Of7
	ceVBNbdEeGWo77rLygPpmORtzAOoutVJ9QoP6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729228908; x=
	1729236108; bh=Nv5e9PalN9ehiEsD+yPrlMtTklPaAwWSSEMCc1ilrnk=; b=E
	YArA03h6vy6zNcVwt9bKjov2daUa8VR4GuJzTHxV2ZaAiADyt4sed8pqzIopwdk2
	CU6XqRNd0HVOl2DXRfiqpgJ4qX5ME6mqEb0jIYkon4sYYXYwyQBlSzo/F4NtxdSf
	7fU0MTAseetSfEF9fU6kOyhKpBpY63qTnSZ2webPg6h0IW9LnOjs1I1G02aVmNsR
	WJXKUrPo9bzev5tVQ6vxfL6db7e3whFE73nJOzr3H76sNpJsC8PT5fQaeV29L9tD
	PH5WWoKjEkts4edAsk8YBDG4oo1AOuAMJ4GnjnkRtbmEWE1XhwhMcAZzD75YvzvZ
	TVa2oPHQMDAUS4351PBwg==
X-ME-Sender: <xms:avARZzH5yRHgOa2BZWi_EXRqJ9Xo3ZXZ4wpP6Mi5XwA5bCIKJ99Aow>
    <xme:avARZwU8A4hPcWPWLmqd37nzcgy73D1zIa3qMkS0uJ7aANyFubhUVJmhrhDQfFA2q
    BZk6lXCRIQzHNu-BCA>
X-ME-Received: <xmr:avARZ1JkSXMrg-qdH1WrVArAFwNxMLtDt7UYLVduSwK9J8AsaTS6DJZ054TersEZ435mVv29brc9GpN797751P5DDojabtV42rb9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjfgesthekredttder
    jeenucfhrhhomhepuegvnhcuuehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrd
    hnvghtqeenucggtffrrghtthgvrhhnpedukedvjeetueduffevfffhleefgfejhefffefh
    hfegieeiudevheefjeffteevfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmvgessggvnhgsohgvtghkvghlrdhnvghtpdhnsggprhgtphht
    thhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghrihgtrdhsnhhofi
    gsvghrghesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhi
    thihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguhh
    hofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepugifmhifvdesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrrh
    hkkhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhesphgruhhlqdhmohho
    rhgvrdgtohhm
X-ME-Proxy: <xmx:avARZxHP3OKqH4myMMS6ZxVIayyOxlBjualprYPn-SmvQcO1r0zxTQ>
    <xmx:avARZ5U0_dcflfGMhqFC09UQNXpYeT8sf_jWKMhEROXXSg8zwRUeiw>
    <xmx:avARZ8PdT6SH0mwogWpKcbv09aI7LecZC3bov0x2iLTaaDk74pDZcQ>
    <xmx:avARZ40voLO4SMc0wwrJe7J0kFLNMV2lbnXg3vm61NBghPTr9CcLwA>
    <xmx:bPARZ-dB1lZHlknKtmuyMgXiOxQ-tbUMDW58GPp2lt61hIiWE6plL_3w>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 01:21:45 -0400 (EDT)
Date: Fri, 18 Oct 2024 01:21:44 -0400
From: Ben Boeckel <me@benboeckel.net>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: linux-security-module@vger.kernel.org, dhowells@redhat.com,
	dwmw2@infradead.org, herbert@gondor.apana.org.au,
	davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, mic@digikod.net, casey@schaufler-ca.com,
	stefanb@linux.ibm.com, ebiggers@kernel.org, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH v3 05/13] clavis: Introduce a new key type called
 clavis_key_acl
Message-ID: <ZxHwaGeDCBSp3Dzx@farprobe>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-6-eric.snowberg@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017155516.2582369-6-eric.snowberg@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Thu, Oct 17, 2024 at 09:55:08 -0600, Eric Snowberg wrote:
> Introduce a new key type for keyring access control.  The new key type
> is called clavis_key_acl.  The clavis_key_acl contains the subject key
> identifier along with the allowed usage type for the key.
> 
> The format is as follows:
> 
> XX:YYYYYYYYYYY
> 
> XX - Single byte of the key type
> 	VERIFYING_MODULE_SIGNATURE            00
> 	VERIFYING_FIRMWARE_SIGNATURE          01
> 	VERIFYING_KEXEC_PE_SIGNATURE          02
> 	VERIFYING_KEY_SIGNATURE               03
> 	VERIFYING_KEY_SELF_SIGNATURE          04
> 	VERIFYING_UNSPECIFIED_SIGNATURE       05
> :  - ASCII colon
> YY - Even number of hexadecimal characters representing the key id

This is expected to be *lowercase* hexadecimal characters in the code;
can that restriction please be documented? (Coming back here, there is a
`tolower` pass performed when copying from userspace, so this seems to
be an internal requirement, not userspace. Might be worth documenting
somewhere in case the kernel wants to make such a key internally.)

I also see a 32-byte (64 hex characters) limit in the code; that should
also be documented somewhere.

> This key type will be used in the clavis keyring for access control. To
> be added to the clavis keyring, the clavis_key_acl must be S/MIME signed
> by the sole asymmetric key contained within it.
> 
> Below is an example of how this could be used. Within the example, the
> key (b360d113c848ace3f1e6a80060b43d1206f0487d) is already in the machine
> keyring. The intended usage for this key is to validate a signed kernel
> for kexec:
> 
> echo "02:b360d113c848ace3f1e6a80060b43d1206f0487d" > kernel-acl.txt
> 
> The next step is to sign it:
> 
> openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in \
> 	kernel-acl.txt  -out kernel-acl.pkcs7 -binary -outform DER \
> 	-nodetach -noattr
> 
> The final step is how to add the acl to the .clavis keyring:
> 
> keyctl padd clavis_key_acl "" %:.clavis < kernel-acl.pkcs7
> 
> Afterwards the new clavis_key_acl can be seen in the .clavis keyring:
> 
> keyctl show %:.clavis
> Keyring
>   keyring: .clavis
>    \_ asymmetric: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
>    \_ clavis_key_acl: 02:b360d113c848ace3f1e6a80060b43d1206f0487d

Can this be committed to `Documentation/` and not just the Git history
please?

Code comments inline below.

> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  security/clavis/clavis.h         |   1 +
>  security/clavis/clavis_keyring.c | 173 +++++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+)
> 
> diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
> index 5e397b55a60a..7b55a6050440 100644
> --- a/security/clavis/clavis.h
> +++ b/security/clavis/clavis.h
> @@ -5,6 +5,7 @@
>  
>  /* Max length for the asymmetric key id contained on the boot param */
>  #define CLAVIS_BIN_KID_MAX   32
> +#define CLAVIS_ASCII_KID_MAX 64
>  
>  struct asymmetric_setup_kid {
>  	struct asymmetric_key_id id;
> diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
> index 400ed455a3a2..00163e7f0fe9 100644
> --- a/security/clavis/clavis_keyring.c
> +++ b/security/clavis/clavis_keyring.c
> @@ -2,8 +2,12 @@
>  
>  #include <linux/security.h>
>  #include <linux/integrity.h>
> +#include <linux/ctype.h>
>  #include <keys/asymmetric-type.h>
> +#include <keys/asymmetric-subtype.h>
>  #include <keys/system_keyring.h>
> +#include <keys/user-type.h>
> +#include <crypto/pkcs7.h>
>  #include "clavis.h"
>  
>  static struct key *clavis_keyring;
> @@ -11,10 +15,173 @@ static struct asymmetric_key_id *clavis_boot_akid;
>  static struct asymmetric_setup_kid clavis_setup_akid;
>  static bool clavis_enforced;
>  
> +static int pkcs7_preparse_content(void *ctx, const void *data, size_t len, size_t asn1hdrlen)
> +{
> +	struct key_preparsed_payload *prep = ctx;
> +	const void *saved_prep_data;
> +	size_t saved_prep_datalen;
> +	char *desc;
> +	int ret, i;
> +
> +	/* key_acl_free_preparse will free this */
> +	desc = kmemdup(data, len, GFP_KERNEL);
> +	if (!desc)
> +		return -ENOMEM;
> +
> +	/* Copy the user supplied contents and remove any white space. */
> +	for (i = 0; i < len; i++) {
> +		desc[i] = tolower(desc[i]);

Ah, looking here it seems that userspace can provide upper or lowercase.
THat this is being performed should be added to the comment here.

> +		if (isspace(desc[i]))
> +			desc[i] = 0;

How is setting a space to `0` *removing* it? Surely the `isxdigit` check
internally is going to reject this. Perhaps you meant to have two
indices into `desc`, one read and one write and to stall the write index
as long as we're reading whitespace?

Also, that whitespace is stripped is a userspace-relevant detail that
should be documented.

> +static void key_acl_destroy(struct key *key)
> +{
> +	/* It should not be possible to get here */
> +	pr_info("destroy clavis_key_acl denied\n");
> +}
> +
> +static void key_acl_revoke(struct key *key)
> +{
> +	/* It should not be possible to get here */
> +	pr_info("revoke clavis_key_acl denied\n");
> +}

These keys cannot be destroyed or revoked? This seems…novel to me. What
if there's a timeout on the key? If such keys are immortal, timeouts
should also be refused?

> +static int key_acl_vet_description(const char *desc)
> +{
> +	int i, desc_len;
> +	s16 ktype;
> +
> +	if (!desc)
> +		goto invalid;
> +
> +	desc_len = sizeof(desc);

This should be `strlen`, no?

> +	/*
> +	 * clavis_acl format:
> +	 *    xx:yyyy...
> +	 *
> +	 *    xx     - Single byte of the key type
> +	 *    :      - Ascii colon
> +	 *    yyyy.. - Even number of hexadecimal characters representing the keyid
> +	 */
> +
> +	/* The min clavis acl is 7 characters. */
> +	if (desc_len < 7)
> +		goto invalid;
> +
> +	/* Check the first byte is a valid key type. */
> +	if (sscanf(desc, "%2hx", &ktype) != 1)
> +		goto invalid;
> +
> +	if (ktype >= VERIFYING_CLAVIS_SIGNATURE)
> +		goto invalid;
> +
> +	/* Check that there is a colon following the key type */
> +	if (desc[2] != ':')
> +		goto invalid;
> +
> +	/* Move past the colon. */
> +	desc += 3;
> +
> +	for (i = 0; *desc && i < CLAVIS_ASCII_KID_MAX; desc++, i++) {
> +		/* Check if lowercase hex number */
> +		if (!isxdigit(*desc) || isupper(*desc))
> +			goto invalid;
> +	}
> +
> +	/* Check if the has is greater than CLAVIS_ASCII_KID_MAX. */
> +	if (*desc)
> +		goto invalid;
> +
> +	/* Check for even number of hex characters. */
> +	if (i == 0 || i & 1)

FWIW< the `i == 0` is impossible due to the `desc_len < 7` check above
(well, once `strlen` is used…).

Thanks,

--Ben

