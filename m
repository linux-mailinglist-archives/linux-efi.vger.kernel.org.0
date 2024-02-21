Return-Path: <linux-efi+bounces-610-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C499485D12A
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 08:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765D4280FCD
	for <lists+linux-efi@lfdr.de>; Wed, 21 Feb 2024 07:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A13A8DF;
	Wed, 21 Feb 2024 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/iGDjhA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5C364BC
	for <linux-efi@vger.kernel.org>; Wed, 21 Feb 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500081; cv=none; b=NaOgdCSWEy1EYw02qUosrcAOBmLUKx4mJC9MXc2yc3EU8LUsrBArSJTzGDka9iV2MwZMfzWNJnOGAtcR8eG76KZaHNTZBLFca8YFL2zLVCciYeapltSNWnP1WuTJ++cLnFHmvNL9adb7QGW+zzwzcAEd4p8ZeQW6PVs/dsGLVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500081; c=relaxed/simple;
	bh=SijJc/wIuNH1gy7HXbK/xEaQaAPhUQ6dKydZEW27bh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DC2zKQu0nAgFNmQ1o5vrJ2fjSyJqqRocnQtjF558smfOcfqT3sah/uGrJ5GCO5dk2zg61PBz02OHxTQSEcBEzhYO2L0Q2HNVPMwoI2hS9O2g5kQq1UN5PkUCJgahzfnr3EFrhFcslEZPBhQpEW4sc6ypnVRjJo9Bem/wXbz2gRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q/iGDjhA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso391098466b.1
        for <linux-efi@vger.kernel.org>; Tue, 20 Feb 2024 23:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708500078; x=1709104878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2BsVV2R37Sw3qoktZXHBNmc73Lk7wn6DNh5+RBjhDU=;
        b=Q/iGDjhAGiIVkUzTO/cm3/nWVN1xB9oYBsrr+IxdN5pJ7YQt4AKkoA8GorMjtsy5ou
         mxDCe47B46M1qYjIr61akWbO1cL8OGPVNYLiQlAnSXJIvpO3H2gb662vPQBaKblEw5mp
         QrJvQg249hRv87RAmPElhyeuVGdBpqbc6zITt/d/JP32u5Rqqh8ej0xUsrcPdQHP2TM9
         D/uGbQVEf7FLfYJKvmPuF0/qFkFzZSE8tAaEk1IEnyeN1td9N2Jm05gjbqQpjsWgHBQV
         YxVmcoKiwi5M/VdZArxgxCvuCzuKenOqHgdLBqxRONPoea9bVbmP8SLnBPf1Dcbwv4Pa
         y0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500078; x=1709104878;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2BsVV2R37Sw3qoktZXHBNmc73Lk7wn6DNh5+RBjhDU=;
        b=gjWLAJCOUVZJ1+8R4WZ4Cp6VpbLxysGz68u6Q5J4aD4Jrq4kQMTCUI1D4S/tkgrj5B
         AChQTnT321xcXeKBp+DY8H+jYP3aIEJXqzmsv03RukLGAPbG5GkHgwh0nCOYLUp/d0qN
         +PTnCgE4p/YJojaVTl+8itwwwDAKfN9Z5/fGjfDyeQfOOOmpd+UQnrHjmd+SrCD/7Cgf
         1ciPSFO+wo2zgC9LiBTap2yEGHy58Fn8XcJIvPaxMw0fBE0DnSNZuMk3Kt7sO1C2Bmuw
         HmmWHDqcQ0mSFHbAsjBpM65eHbD+naTad4SR/Zyhwr+EZpiCpXfO0gpHCmkoaCaF9KeJ
         S4vA==
X-Forwarded-Encrypted: i=1; AJvYcCXe9LeTFfsFm0gpMkalIqVqgut23mXkwxwqirtn1VNJA6JgIOunPh5MdwrKpqSKNIJihzELfYWtQvY9oKoSdD7WRP6rx8PkDMST
X-Gm-Message-State: AOJu0Yx0B/SirmEhQWEwX1PDjc0UCSKZ5GcxCAgAl7fsVD1gVE8Ncjn5
	+YC6Psooz5t+X7fWpO7LwBGkf3JBjGFVMPK1YbftY+FojpOEZLBnlakoVjwmP6w=
X-Google-Smtp-Source: AGHT+IFLXrNiZk5Qdhzc7Fz88jUdKWeXWiWkINHgJ30XNSzlO3qSJhjA+RUPQ+2BtUmFzNc59HQsdQ==
X-Received: by 2002:a17:906:c105:b0:a3f:52dc:786b with SMTP id do5-20020a170906c10500b00a3f52dc786bmr140285ejc.23.1708500078714;
        Tue, 20 Feb 2024 23:21:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id vi8-20020a170907d40800b00a3d61775382sm4653366ejc.0.2024.02.20.23.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 23:21:18 -0800 (PST)
Message-ID: <5d8a4ee4-2657-4750-8263-af1baae2c91e@linaro.org>
Date: Wed, 21 Feb 2024 08:21:16 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dt-bindings: Add post-init-supplier property
Content-Language: en-US
To: Saravana Kannan <saravanak@google.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Len Brown <lenb@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240212213147.489377-1-saravanak@google.com>
 <20240212213147.489377-4-saravanak@google.com>
 <20240214-stable-anytime-b51b898d87af@spud>
 <CAGETcx-tBjfaLQqmGW=ap2N5FLK_gvTzxskA6sVsr_SUEpvomA@mail.gmail.com>
 <b7fcb71a-e3bf-4f50-89d6-caff9f3303dc@linaro.org>
 <CAGETcx8XBj=vh_e3vyXuj8oQYA3UC4uy9h9K2OmwBxZ2G_ms9Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGETcx8XBj=vh_e3vyXuj8oQYA3UC4uy9h9K2OmwBxZ2G_ms9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 05:07, Saravana Kannan wrote:
>>
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>>
>> I assume you develop on some older trees, because both next and v6.8-rc1
>> work... or standard issues: old dtschema, old yamllint.
>>
>> I am afraid you do it for some old Android kernel... :(
> 
> No, I always develop on Linus's tree and test it on an android kernel
> that's behind Linus's tree by a month or so.
> 
> My yamllint version is 1.32.0, but until 2 weeks ago the latest
> yamllint version was 1.33.0.
> 
> And dt-schema is  2022.08.2-5 and I had to revert this from Linus's
> tree to get it to work:
> b32dcf23a03e dt-bindings: Drop kernel copy of common reserved-memory bindings
> 
> Unfortunately, AFAIK, I don't have permissions to change the package
> repo, so can't really install a newer version.

pip packages are by default per user, so why you cannot install updated
dtschema?

Best regards,
Krzysztof


