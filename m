Return-Path: <linux-efi+bounces-1998-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FCE9A299F
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 18:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455641C25706
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB11E0B70;
	Thu, 17 Oct 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iICARHoM"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C21E04A5;
	Thu, 17 Oct 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183863; cv=none; b=KyrRzMzUDPx45EdbRy9U431JrwZm62nNd4JGsogwFbYUSEHGrMokhkOzOuI6w3nasX+f0mWoHBGT0jOIMDyU+YdDdJCCOVyexd4QeA2xrKgjz5qapPqSqZXFgc0bU12I9G3DycbtVM6Gh69BoCuE7GUczDXT5SDnW674aKFpd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183863; c=relaxed/simple;
	bh=nu+/YY2gR1ZzMVmhhVOVpo55R32dWjS/8gyLH+/tacE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGX53718/RWKgSlCL9M4ccPBb7uE9UD79LwZ6RVGWO2QLe6QBENTgP+MJa7lul/qAKkHKDrNgC5ui+US8AOSpCGCd4H9obhaYuTl9pMDPpm4ia0YDi8vg5WFR9hTGkqgCB4AdZ5y7pT+yZMJu7zi1FuPi2taQmR9k2mqFvzlVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iICARHoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EB0C4CED0;
	Thu, 17 Oct 2024 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183862;
	bh=nu+/YY2gR1ZzMVmhhVOVpo55R32dWjS/8gyLH+/tacE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iICARHoM8EgPqapQHoINNY0ekt+qzjg1CjSVDrIVOjf2hK6MJ47ONuiS21GKhOA1M
	 VMwSp8wJ6Yo6UJ6A3kch7OgcsEb4XGHW5VK2v1BVZxbid9qor8LUIM1LQxN7i1LAhI
	 tjjG+Qcv5cUGDm5D72px83isytUA02K0Fp8YJz5dfIoK88s+Lt+oimaugi68HJKsrx
	 j8I9uubSdds4qf0Pixbs07UM+Pk7bkHSQBjGh4uYi0svsDZnDlqU+roUMoYYHAOZ9F
	 u7QrXom4Gl7VFAid/4CWPymwVxYFiyEtAVfbb/GPn08YkwIWbcxqn4Ht/AiFZ+IdEt
	 a9KLZ+LE7WpEw==
Message-ID: <30308614a1229870d205c33deba193f3d6732bef.camel@kernel.org>
Subject: Re: [RFC PATCH v3 03/13] clavis: Introduce a new system keyring
 called clavis
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Snowberg <eric.snowberg@oracle.com>, 
	linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, 
 davem@davemloft.net, ardb@kernel.org, paul@paul-moore.com,
 jmorris@namei.org,  serge@hallyn.com, zohar@linux.ibm.com,
 roberto.sassu@huawei.com,  dmitry.kasatkin@gmail.com, mic@digikod.net,
 casey@schaufler-ca.com,  stefanb@linux.ibm.com, ebiggers@kernel.org,
 rdunlap@infradead.org,  linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org,  linux-crypto@vger.kernel.org,
 linux-efi@vger.kernel.org,  linux-integrity@vger.kernel.org
Date: Thu, 17 Oct 2024 19:50:58 +0300
In-Reply-To: <20241017155516.2582369-4-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
	 <20241017155516.2582369-4-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 09:55 -0600, Eric Snowberg wrote:
> +static struct asymmetric_key_id *clavis_parse_boot_param(char *kid,
> struct asymmetric_key_id *akid,
> +							 int
> akid_max_len)
> +{
> +	int error, hex_len;
> +
> +	if (!kid)
> +		return 0;
> +
> +	hex_len =3D strlen(kid) / 2;

Hmmm... I'd consider sanity checking this:

	size_t len;

	/* ... */

	len =3D strlen(kid);
	if (len % 2) {
		pr_err("Clavis key id has invalid length %lu\n", len);
		return 0;
	}

	hex_len =3D len / 2;
=09
BR, Jarkko

