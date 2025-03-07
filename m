Return-Path: <linux-efi+bounces-2917-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DE4A56192
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 08:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5782F17257E
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 07:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5851A314E;
	Fri,  7 Mar 2025 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXd6LGeY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9811A314A;
	Fri,  7 Mar 2025 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331382; cv=none; b=IEAw3Q+SJFJt9reeimls2BZBNIpPDGwO/+ZFRmtexHln25JbBMOwgYAgiuWafE37eKNIVRcCD2gljoq1VeuLZ4Am7eOvJvAjDorcxGLFQYc4tNq868zwyWArhhM4+cs2utJYbVCDYmC4968tYUMO8685yw/tnBYqiNprgw2SSPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331382; c=relaxed/simple;
	bh=s1sKDyB3KwoorGYkRUNMSWK+weQ2ZgqEryheJlaust8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGa3AmeK7MMZB2TrPlJZb7pToY/++lBBMBIxnbRyEJwtmCabiUtLhhylK1xT6uwTkFL+/nyVzcocbj0ZWSHI74LzJbl+vcVK1dQMYQgT9xoInizx0YZq2I6nTCze3OIIDJdAemxeZTwjqJFTle/NHCtayRO2HnEi9ABrrJ5AH/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXd6LGeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025F8C4CED1;
	Fri,  7 Mar 2025 07:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741331381;
	bh=s1sKDyB3KwoorGYkRUNMSWK+weQ2ZgqEryheJlaust8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXd6LGeYM1ZUHYTADkI/CgYdZN7wl00h5VkIkciSLi5bq0LEugYucScv2usw2KtZ+
	 inYH6JhOi23F5ivtzCXp41XPoKEnKvOkm8PF8Xj1CMzyHw7BB+nzfDIUUVYRZlaPyH
	 jfOtsPzjLt92Z/FTAKjEVCfNRE7hG8DCho+sgpyCVPbqJMp+XtdYwx6Pz43dV87+1f
	 hLbVNqE9vWMI05GpDaPRngEEWnEerHRWOwy42gh38i7dqX46Y1PLXgmlBNqo6Jlgpc
	 RIjN5h4k819B9+XAxWAtZh/ZeeylT78bE+9ZIwhUOgwrcLwH/4XxvYVnC+q+MzSSCA
	 /U582UJWb8qRQ==
Date: Fri, 7 Mar 2025 09:09:37 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 17/19] tpm, sysfs: Show locality used by kernel
Message-ID: <Z8qbsdX2hTathvbs@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-18-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-18-ross.philipson@oracle.com>

On Thu, Dec 19, 2024 at 11:42:14AM -0800, Ross Philipson wrote:
> Expose the locality used by the kernel to sysfs.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm-sysfs.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index 94231f052ea7..2da5857e223b 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -309,6 +309,14 @@ static ssize_t tpm_version_major_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(tpm_version_major);
>  
> +static ssize_t locality_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct tpm_chip *chip = to_tpm_chip(dev);
> +
> +	return sprintf(buf, "%u\n", chip->kernel_locality);
> +}
> +static DEVICE_ATTR_RO(locality);
> +
>  #ifdef CONFIG_TCG_TPM2_HMAC
>  static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
>  			      char *buf)
> @@ -336,6 +344,7 @@ static struct attribute *tpm1_dev_attrs[] = {
>  	&dev_attr_durations.attr,
>  	&dev_attr_timeouts.attr,
>  	&dev_attr_tpm_version_major.attr,
> +	&dev_attr_locality.attr,
>  	NULL,
>  };
>  
> @@ -344,6 +353,7 @@ static struct attribute *tpm2_dev_attrs[] = {
>  #ifdef CONFIG_TCG_TPM2_HMAC
>  	&dev_attr_null_name.attr,
>  #endif
> +	&dev_attr_locality.attr,
>  	NULL
>  };
>  
> -- 
> 2.39.3
> 

I think we are now in good standing point with TPM changes.

I'd really put focus now on unimportant seeming but actually important
documentation full refinement. It has all the infos but it is torture
to read still :-) I did put detail how I would like it to be edited
(personally, perhaps others could comment that part too). If it was
a bit more punctual it would be easier to follow rest of the patch
set.

BR, Jarkko

