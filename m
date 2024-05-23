Return-Path: <linux-efi+bounces-1077-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45AC8CD59E
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 16:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824301C213F4
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058C814B963;
	Thu, 23 May 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDO0BB+N"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD014AD17;
	Thu, 23 May 2024 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474207; cv=none; b=HfWONqAJD3IKUXDJyd0NmRlS+9LHZQEFkjMgDG4i5rujKrhz4FtRTq9RxRZnCoKKYciPZT9qciDoHMrekTd/pnp5G+vDBA4ZFdVx2Ya+uEoghG0Y0BYuNqjkLdbEChgpTHrF7Bslg1g6ZjcLeNLopOkdXHHmmJxSggs18sTWkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474207; c=relaxed/simple;
	bh=JJ7bmhmcdNu8MKywaSirfkV+WFbvuDMYyJFOVkiBXjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVGwibRh6TNM7Kt8XGwjndoA4Zp5M9ckOJfUWTbYmSfZRy69lVGYHZtbOwVy8MVVNMUlByvZVxAHATUi1y7XA6CaVtdiQSI6J2KfLMzhYnExevMrdklMmhNsfs/Bo5WWlnBAR2i+oiBrJn30wJBi1kJiJQ9Vpe3G3nwdwDwmkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDO0BB+N; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f44d2b3130so3432754b3a.2;
        Thu, 23 May 2024 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716474206; x=1717079006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/lNADwPwr25pysfe9uC4MhtrxN5wTcZxfw/uoqzjrk=;
        b=YDO0BB+NuwXlDvo2rV6k+PnTabfQjYkUWTwhya2kRn5s6sWfv5pR4qpoypnBo2FeQx
         Pklz2TPD9BSqfNAQEc71JRvuxwLU043Ds67z8lFUNJJdYpWr/Ci/aCpSP0LKIE0IuV9f
         BVLJe1AA+i9K+z0DAesYeMz325uU6uZJKq6L6I3on3sOYxgnSLm6QYr7TF5dRJ7MPya5
         l6EuyOBU7mp3Ah4w0436OJ3hE/ihlvQlx7V026s13nL8qKGqlqAzXFQoXqGQfMArcnZ1
         ZzKvRAxrmWoTKS/Nq4VY9zFwzmzxoTmw7ocTNAtlMhd7FnwlWDHpMSidklQ7gJN2LFFY
         7fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716474206; x=1717079006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/lNADwPwr25pysfe9uC4MhtrxN5wTcZxfw/uoqzjrk=;
        b=NfEa19+L7gnVJuzlDoWGxSvtb86XJPEFD1TZH7owPpz1MuSQXn0svYq7zGMOGxbobG
         8CnRZQ6LtIkrtAvFnI1tVwEouLLrBXasy2ZpXpcZ/J/5qq4rkU/ryaGkgME/QNQ4+aft
         JweF7SXIpWcLhLIFbgC+cs0vTpH70rdjL21lWy2l9b77oSqJE5p9rS0D5Ga0+4wkZumL
         Yiu+uX6zNDzXTDqZomytksesOGXeR+bStXQJcUIOUgzA6I+Na58k3+7XhupNW2okE9JA
         6IGFqZF7R4w86bJzLjzyNCWR+1YBJL4J3g06mfeDIw/zsJzStnva8S9iNAPVp54AcGHU
         bfPA==
X-Forwarded-Encrypted: i=1; AJvYcCWjHAE6F+VoqdoKmYRB2eJZNF81Ob33+iwkV0RXPCmQAXA1i9ToHXGTDA3YFDZKKbl3ZtYGFsQ+P3OailIiNtinE2IrzsYo6pQjiUJxWurEZAz0zeEHRT9STnnGKw1VMIKUZOW4gpUuyZjJJ+vxgmxUNAPWWDG0J8/T+SfUHsNv0jntw8jh1ZLk34REL61QGpsVx0qFcKbgrOgUgxjJ3qtPk2t7Zu7kePfzpQtxj3J/wGSGhJbF7A1o1msWHw==
X-Gm-Message-State: AOJu0YxXqSq2QlwYUf6LiVmLHzK7pIwMewxwsg4a6BRB42bHDNMmn9kw
	mPUKaF+5I+0nl4Z/oukfG4yGokdLcUpdSY32okVv0YeSm3zP5ZzX
X-Google-Smtp-Source: AGHT+IEWmE003niz8KfDtTyBhJFuwL9l4X+RCaG61wMtnhF90Faa7QASay0WGaxzbP5zU+5qgt+XNg==
X-Received: by 2002:a05:6a21:999b:b0:1b0:31c8:edfb with SMTP id adf61e73a8af0-1b1f8a8669dmr5803662637.60.1716474205714;
        Thu, 23 May 2024 07:23:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a665c0sm24088995b3a.3.2024.05.23.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:23:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 23 May 2024 07:23:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	intel-gvt-dev@lists.freedesktop.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH] sysfs: Unbreak the build around
 sysfs_bin_attr_simple_read()
Message-ID: <a396a2ce-656b-4525-acee-ed7c3742b2da@roeck-us.net>
References: <2024052334-nape-wanting-0a2a@gregkh>
 <05f4290439a58730738a15b0c99cd8576c4aa0d9.1716461752.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05f4290439a58730738a15b0c99cd8576c4aa0d9.1716461752.git.lukas@wunner.de>

On Thu, May 23, 2024 at 01:00:00PM +0200, Lukas Wunner wrote:
> Günter reports build breakage for m68k "m5208evb_defconfig" plus
> CONFIG_BLK_DEV_INITRD=y caused by commit 66bc1a173328 ("treewide:
> Use sysfs_bin_attr_simple_read() helper").
> 
> The defconfig disables CONFIG_SYSFS, so sysfs_bin_attr_simple_read()
> is not compiled into the kernel.  But init/initramfs.c references
> that function in the initializer of a struct bin_attribute.
> 
> Add an empty static inline to avoid the build breakage.
> 
> Fixes: 66bc1a173328 ("treewide: Use sysfs_bin_attr_simple_read() helper")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/r/e12b0027-b199-4de7-b83d-668171447ccc@roeck-us.net
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  include/linux/sysfs.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index a7d725fbf739..c4e64dc11206 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -750,6 +750,15 @@ static inline int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
>  {
>  	return 0;
>  }
> +
> +static inline ssize_t sysfs_bin_attr_simple_read(struct file *file,
> +						 struct kobject *kobj,
> +						 struct bin_attribute *attr,
> +						 char *buf, loff_t off,
> +						 size_t count)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_SYSFS */
>  
>  static inline int __must_check sysfs_create_file(struct kobject *kobj,
> -- 
> 2.43.0
> 

