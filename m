Return-Path: <linux-efi+bounces-505-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DE18509AB
	for <lists+linux-efi@lfdr.de>; Sun, 11 Feb 2024 15:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64964282068
	for <lists+linux-efi@lfdr.de>; Sun, 11 Feb 2024 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A696A5A11F;
	Sun, 11 Feb 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ri1mjy+7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889D1DFD8
	for <linux-efi@vger.kernel.org>; Sun, 11 Feb 2024 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707663130; cv=none; b=nX7uAKQ6sGTBn5HXCbfbvnc1RkcS9zXpQhhhJR0c6y/uZ86/KS7zbSY6w3R4XmjfGz/Opk9/2Vb+xth247XlFtB16VIVvNVQ7kl2/AHJf1jQM6MuoPBIK7RZfL5RNVON7YoxujEHN6CF1PnER33yojOMeOovxSFSvjd4h6vLWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707663130; c=relaxed/simple;
	bh=akPs4ic2npN944w9uoDhIDSuo+2cQoHE/g50WuXE/aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXNrd7AsSjMr5B2qRcbSYW7kQL3b6ktznHMXWSf488JRKh3HQJX9EAbUSyHkeh/XU+SdS/geJo3/ySBPZ7ec39jBVjUxF6ph8gwTNzfl51GFpitduVIePeCDonMt7sZOhbJ8UHS2XDF4JpTSDenz3dbXjK5b5Ku+7iKPGCc9U+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ri1mjy+7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4101d4c5772so13602925e9.0
        for <linux-efi@vger.kernel.org>; Sun, 11 Feb 2024 06:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707663127; x=1708267927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=57CKClG5X0Vlg2RBUhylrYTb7t1l/cmHjDC9W+jrWys=;
        b=Ri1mjy+7KXFh3T9qhhLB+tcyzbaoxSKURrlhn2UEuo/4xXMCDszQ/sGDLFiuiTNzpQ
         53B4ha/3AK2aakS1hWnKKXHd5894l4pQ27DEHefNVnmwYZPH05BHF27qO0gY/aKvFcjb
         5w/9xQSYfXyokYOyEybeW59TmFw8Me8rbuYVeFVQJQqRh2JNr1lZr2FmObG5pms/wEfm
         SwCYy4WSHQk7zrR36JJm94BSr1JNvgTAXJmvbmpvAyqm7tb2xkeJEZ1BkF4e+q4NIQE8
         qktuzXdvMTiUWP96es4CHfPeemaK5g20bLd6lnJOxW6H6f9ABJfHppE8oUft/rRD8ucH
         dQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707663127; x=1708267927;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57CKClG5X0Vlg2RBUhylrYTb7t1l/cmHjDC9W+jrWys=;
        b=AW1CNozCVoHbST1QkdwmBrOVMui5cxP+SVOFE6V5y489XrAYxCUsLswIp93WXGMK2b
         vrW8A7T1p+QuVaGtDKCkTD3SybY/aZ2Qd5fPW5hlQUvQAM7WMoGXzUd7/BXLigkvgFJD
         VgIF7ol3DMQhTUa1ZuJq5vEGXar6REMABcfmWXGV+lrhyUWedY91/Ts1N8z6vVPyUzqJ
         3VUztvCtS+JxQdk19MRzMgGqzh/4praw3fESuNnBxdZojHIbtregGjTdDZaS63uTepNn
         7/ZRMn9NDUmAYGXReZXqtynCovj1Hq0rXnINkT6J0AY/2kz5ByfFMiiRvIEACTGfnTOH
         hlmg==
X-Forwarded-Encrypted: i=1; AJvYcCUYyobOuWV6uBApGfhYyrIPrUfsLUgY5sExBL3QHuSKR/9VyKApyDgs9mfSgDL7Xl1QQANQu+kT7QEEVTuTvttnya4yWbnZ8Fv+
X-Gm-Message-State: AOJu0YyEX8F6xjkCz845TdpNwVzo6/ZIv/l8I3T4r2bl3YjNR62h1+Gz
	TFqDOfdt38gBC1IOngh2bEGaQ0gVRcGz5ya1nc8MNxWCDgcw44L5BtoyoWzzm8I=
X-Google-Smtp-Source: AGHT+IG5/HODDHSHhpKYxxvXrHzAyVHmrYHxegil02oRxyNf5hTaqCkLQqwcVjoWh4YAoIVBNBxQiQ==
X-Received: by 2002:a05:600c:4f09:b0:40f:bbdb:4f2b with SMTP id l9-20020a05600c4f0900b0040fbbdb4f2bmr5229793wmq.19.1707663127108;
        Sun, 11 Feb 2024 06:52:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwWRqroDV8/WtU+IwQEaoPCJ7A7V2Im4LsT2vbSs2mpxQyrzv+UIQBItOg2ASgDmAHfkpYTUdH9QG3bBwnXeGu4IsZFrirbrS432OLn3PUTYNPjCkNTh5KsFDcTmXNxDX9HNoObkZPwvt8sIPpKFVEENUUk9lN3KeNWQsaooZx3rnZtwaaA/geI+p8lZpr/Mutff8a/arZxaGkR5eX08yHh8ZvoQiNhDus6+At+qgcfzjtaEWv28p2PXvA4Apvm1Fj5t/7Y+dkQCMeJJUPm47KMTUq/iSv/KMaIhNSm1OygD4YXMB6CamLT+QUdxqFhKoAyfPzjEpsZvwdGSkr16aEalSij8eGv9po+1n2n2NJRs6rlXe58EwoHAnRlGSKAThSDLk+3KSXbzUtldTSFI+JVIhEfR7GxCAllBGlJJyLErYt1IyOC3i3U96xJT4zML6EgrjWf0mevcSvPqP5SyCezzMwmDZHN9crue2UDl9gqgup0hRmlToOj5JUVKr7CLY6TOC1IAOE2/S5eFSFUNxf01O3eyhIvMnyLtHdHq9TB/zOHVz+/v2yhDMA3PplGIBNZu9UmGiASGcCHV5LyS/HFTu2kzkDwKR/AY0=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d428c000000b0033b4d603e13sm4392289wrq.51.2024.02.11.06.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 06:52:06 -0800 (PST)
Message-ID: <05e4fb58-f075-4995-9331-c3f8e8a850de@linaro.org>
Date: Sun, 11 Feb 2024 15:52:03 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] dt-bindings: Add post-init-supplier property
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240210030549.4048795-1-saravanak@google.com>
 <20240210030549.4048795-4-saravanak@google.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210030549.4048795-4-saravanak@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 04:05, Saravana Kannan wrote:
> The post-init-supplier property can be used to break a dependency cycle by
> marking some supplier(s) as a post device initialization supplier(s). This
> allows the kernel to do a better job at ordering initialization and
> suspend/resume of the devices in a dependency cycle.

...

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3dfe7ea25320..40fd498543a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6055,10 +6055,11 @@ S:	Maintained
>  F:	drivers/base/devcoredump.c
>  F:	include/linux/devcoredump.h
>  
> -DEVICE DEPENDENCY HELPER SCRIPT
> +FIRMWARE DEVICE LINK (fw_devlink)

This breaks ordering of MAINTAINERS...

Best regards,
Krzysztof


