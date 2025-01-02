Return-Path: <linux-efi+bounces-2494-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3423C9FFDB6
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2025 19:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE9857A16E0
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2025 18:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C23A1B3944;
	Thu,  2 Jan 2025 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MICIcgJE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721118CC08;
	Thu,  2 Jan 2025 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841849; cv=none; b=tejf8ANPDkODnX5qKAwxoddqRjmL+U/bBqgcE2WCLc9DKZ/h3cbUBTkUIBFkgAQiW1c8b7eZAVTZ9bEPJvoWBTGUs5Y6h5AfR+wCd+Zuhxk07WajdfzFPufNnUOaZPk5GEIHNDri20bLLgE0xo/6/GQ47SMezGdYKOBXVzsYNcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841849; c=relaxed/simple;
	bh=56KyMH36kkt8ZIoRmqH2Gmj+Cu5YZ7EcdIm5YbsdOdw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2xT/nvuEADO0RvWJJH4j8WCy23wKR/GIRXzz781bHVD+P88COBUkjexiRsnV4QF6tqkM49m6h+ixhyDS4V3NjJD4WvLH7y9i06qpFzhxxaZ5zLE8Yln4hRQX+Oy1eGT6jj+j8VzkGJAXvcEVS9Vz+3Xrl61rZ9r2EdJ5XOFb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MICIcgJE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21619108a6bso147268015ad.3;
        Thu, 02 Jan 2025 10:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735841846; x=1736446646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KcsYGT2jr/Cwk+E0bZ78S9/+2iE2NBGtFjNzzo30vdQ=;
        b=MICIcgJEOZmP/BRp7qCOoAdpJq2JvRaMGK9YhSgx25d5Fz1yNQr0lePr4dUcAqtmoe
         DnzwMvt+gZPenrtzo+yWWSQrcyeZiEBOwPGZ4+bcUs/FkUqh/d+3M3GgN7/IsPF3xbm1
         5izJFNrVwAUrBomHVDRB8ezEwq3qcLWsRYU6oz+M5FNcGJInC/pUycCZu8HnF0lXTCNK
         7Sz0okHfRD4rCPnt0BK3sGZdmwGqkgeS8+JibIQ5bxlsEcB8S93T4zIPWvyEvIGb4+qP
         ztJxOQOJVnlYXMb6iBdK1JrFrDWSbRDdNHx8NSmnxTULHmZKUah1iHkvuVXzK4g0pTjg
         R8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735841846; x=1736446646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcsYGT2jr/Cwk+E0bZ78S9/+2iE2NBGtFjNzzo30vdQ=;
        b=eInCkkKDMgR921AAh66JotGpRnwnvUg6vkEHlZ2LUVO3s34qQb2pubweqVOLyccWh4
         vlvBQifSpYnhUJE63d5snsDASS3MHaYVwHRvzrlEtl1ioVYC4SWb6eXBw9BgN4/WK2Ek
         PE2imIe4GGyjvZnEWHHjLMtBhj5RpDu0HnB9LsvGOr7yi82q8piyubM+uZ7Gx8u1lOKZ
         vvRxH0uQbCvVjTYzE9SI3hn++yW/2P+RQSj7D1Oxl9R0ARSILYBKDaoMY6BpOan/1/AB
         J3LQnHePvBmK7xww6LW5wN6IUnXKfEnDs52Fo9eUjv17z5QuVu/NuNlPTSh12wq4BlF+
         So8w==
X-Forwarded-Encrypted: i=1; AJvYcCU+7DnxyDdnNRrLgP1uwUWjz7DbzFnKXttYC8+ZtRftIBu6TPamzCE2wqPMHXF5OXSorQKbF/P7h8AY@vger.kernel.org, AJvYcCU7T+A1o24m1ROEHUyARpwW/Y61mhNWvSH2OQdXDOwxnxXn/PQ7eKBf6snNQju/hffli74Dwikw5A==@vger.kernel.org, AJvYcCUK8hKIlL0DBPQRfZdVvmxWkzh78+jeHKE7blZH7ykl8llbbVVPWHkbqRw0eocB1tQQ1J9+HWW01A2xSg==@vger.kernel.org, AJvYcCUM5rODagHZnjEayEtNAOeO7HsEAqVxa4veY+UQARi1oKwBRxdbC//kKKajqefV4XS2lZQhylLLfApgQS/1/Un/Qw==@vger.kernel.org, AJvYcCUwE01hKDW0w05LoNMNRsTbnwHuadKTnlV8J4Tlf6os535/BkAzb+8TFUYnDzRXIZ7RvmR1le2EFxBYJhuj@vger.kernel.org, AJvYcCUzbiUpJqAHpF0ydPvklpRUhuP6o/ti1qc7m6Rn5xGRRCNZifiTN7B5esil/r9ErR7J3aMO9WLO6xEKsA2J@vger.kernel.org, AJvYcCV5ptXYlMNx11DGCIPpxQG0ewUhjSM3VkLOTeuFJV2n/IgtdsJQqDzLGMONr7CZI3xuSlW2AW1Q97uuS9E=@vger.kernel.org, AJvYcCVe0RhVbsTwk26oJ+WdqwcPCEzt2ez0uZ7vS4/Kq8ZoA12eJ3lHIvJLNtXMahXCIgdQN188X1/IF9mtrkE=@vger.kernel.org, AJvYcCW0SoZ9oYvZsy/wdDu3jEZxYOz4XRUcBDtTZxfrMKLRtW0ppO2tB3madZQkLvKPDpTG1Uk+oIuRCMASRqM=@vger.kernel.org, AJvYcCWB7W4X4GSh
 3t8/eTCGSjIwGN2D2TgAEwJpX7bT40z4cRMT01NCYriVjEhKX1+CCPQjMqHZuBNEwGmY@vger.kernel.org, AJvYcCWg8R9Fi9Fc6l7gV9YigTgovvV+MNb+ckzdNkmcZ6E7kDKkQWowlXt7l+dJA7iXDWzWsq2A8lAB6vfZgQw=@vger.kernel.org, AJvYcCWiWcIEv7SEhsqh6nU11fVOku+bmus81pvwdEweMA+IqHC7fmpjot8r6Vap5biuhm5hUnYx3HtqXJcOew==@vger.kernel.org, AJvYcCXMiMrq/r9TNkZvnqplrz7FP9EzDh/6rIluBINPPILGobc5SRWnPnUz9NDC6XK0jRvZUEM/Y+remTf6@vger.kernel.org, AJvYcCXo+/PkazWtQkFxb+tp/l5BuP5iRhETNdHBrG2/gbMbMjCi4SJXAmzjhOzffYAQoS7YV9FPaJ5i@vger.kernel.org, AJvYcCXtgfPuBAY+hhtHvmAFFq+FeXSxRhTFXxbuo/4GjgKQVhRnzCCnxVSs28t9G5ixMH/k2iBe1/SjarCg@vger.kernel.org, AJvYcCXzBZbs/h6iJ4wSCMvpaOCmWcAknkfX4ve87b9mJR9Kn/CpoH5nSYvaCfwQDV/EvrO3IZkEiZqy/gCFMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+zheiDoesdeAkJ7MZDUyl6Hqdh9mOdiZvJJXex6L/g4aewH12
	V8cRuOuX6fKt2PqIBo61qo+iBbiIerdaLsLbO54Dj3q3nCGvMKnqMHJpRg==
X-Gm-Gg: ASbGncsNx027htFcKzSVIknAx/B+CFdENdF9nT8Whw9tqCIuuZwYljbQREgZF3wce9/
	yN8H8bYffR3CHAlVMQHRZAOserfvR2FScwKrGyzwBm6/GO5d0NmOgvuk/TXjDED/0FM8cAjuvaA
	BvcLz5fmp+1FttDU85GMmJLOxBvG+17gqEeXPyhwWcnFsbXII72YdzR5GvplQ1KJAyA8cuj0URq
	zcVkItEcZm8Rbd9OEL4IhEJdnajXc7B4D5LOlH7h8vePghFUS/izV3PBgog
X-Google-Smtp-Source: AGHT+IGUftEvjzgeM5eRfZJQJDkV96dM36oyQ3FUyp6cKSKianTN7IVhYXtyu9gI0RnxWUv7Qt/Czg==
X-Received: by 2002:a05:6a21:78a5:b0:1e1:a0b6:9882 with SMTP id adf61e73a8af0-1e5e046331fmr66924613637.17.1735841845904;
        Thu, 02 Jan 2025 10:17:25 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816305sm24535993b3a.31.2025.01.02.10.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 10:17:25 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 2 Jan 2025 18:17:22 +0000
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-sound@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-block@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, arm-scmi@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-gpio@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v4 01/11] libnvdimm: Replace namespace_match() with
 device_find_child_by_name()
Message-ID: <Z3bYMiOG0u3Jtv3h@smc-140338-bm01>
References: <20241211-const_dfc_done-v4-0-583cc60329df@quicinc.com>
 <20241211-const_dfc_done-v4-1-583cc60329df@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-const_dfc_done-v4-1-583cc60329df@quicinc.com>

On Wed, Dec 11, 2024 at 08:08:03AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Simplify nd_namespace_store() implementation by
> using device_find_child_by_name().
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/nvdimm/claim.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
> index 030dbde6b0882050c90fb8db106ec15b1baef7ca..9e84ab411564f9d5e7ceb687c6491562564552e3 100644
> --- a/drivers/nvdimm/claim.c
> +++ b/drivers/nvdimm/claim.c
> @@ -67,13 +67,6 @@ bool nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
>  	return claimed;
>  }
>  
> -static int namespace_match(struct device *dev, void *data)
> -{
> -	char *name = data;
> -
> -	return strcmp(name, dev_name(dev)) == 0;
> -}
> -
>  static bool is_idle(struct device *dev, struct nd_namespace_common *ndns)
>  {
>  	struct nd_region *nd_region = to_nd_region(dev->parent);
> @@ -168,7 +161,7 @@ ssize_t nd_namespace_store(struct device *dev,
>  		goto out;
>  	}
>  
> -	found = device_find_child(dev->parent, name, namespace_match);
> +	found = device_find_child_by_name(dev->parent, name);

Looks good to me.
Just one general question.
The function device_find_child checks parent and parent->p, but
device_find_child_by_name only checks parent although they share the
code except the match function. Why that?

Fan
>  	if (!found) {
>  		dev_dbg(dev, "'%s' not found under %s\n", name,
>  				dev_name(dev->parent));
> 
> -- 
> 2.34.1
> 

-- 
Fan Ni (From gmail)

