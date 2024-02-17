Return-Path: <linux-efi+bounces-580-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E521F858EB3
	for <lists+linux-efi@lfdr.de>; Sat, 17 Feb 2024 11:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771BD282A7E
	for <lists+linux-efi@lfdr.de>; Sat, 17 Feb 2024 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A682CCB4;
	Sat, 17 Feb 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0Ek3M1m"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6562C85A
	for <linux-efi@vger.kernel.org>; Sat, 17 Feb 2024 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708165669; cv=none; b=KT1Pq1UwoVTE8iTiuk3NPPxOTCm+ds6VY0DSyYO9IX6N8TnULRghFBKvLy3zw/CTUCGj8pdc37oN++R8xRf3H6+eV6dWI10ilq/4nLylN3EioKociSPxms6S4G3tKZT/zHfkPrLy5+6XIoNTvd6PW1mAWHDdKGT0+qFIITYyMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708165669; c=relaxed/simple;
	bh=ITgI8wtXqvIXeUHgFXHCH7Z/ODX/Zp0/cZW85LaK3GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DspsLTEIUGtBDq2rqFkcQDpB9oHqPbcVtBT+NStSTiwW9en0yRe2vESvmQH6fv9Ly5a1b23SleL8tyVHE2p5dFY3Js2DU0udGA5Wovrj5kIoc9ngk+/TGCkXk/ciQbeDULvBk1sF+qz4qDGnKmoGoZoikDF8ag1TnEf5cbwLSyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o0Ek3M1m; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5610cc8cc1aso3036331a12.1
        for <linux-efi@vger.kernel.org>; Sat, 17 Feb 2024 02:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708165665; x=1708770465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6wGmVKMUMPFGBDWK1cKr8wVY2QYEjHS28FhJFBjkZo=;
        b=o0Ek3M1m68etsdzvk9nT6q76Gygz7bD1sFX8TBbLf/OQrmFDrUMYH7GYlrDSzHJ396
         3kHr86Hxt7lU+1qyI3rWdOrhl6LTf+uU/Qx0SHGUFePhGgRMkUy29D3cMNH7EAdDKj3h
         DihlqJzYIT56uXcZoXBM8dPXOEs28SEtWwOhufLqzaC1bPZSyQLHftgoY9jGNO+KLAOZ
         jdyqPeQm4upNhiz1LNnt0TUlJCU4V/zaZJd8GTrZ8OiFePknW7edfQhrIE5Y768wz/W+
         akjvtsEv6Oip4D5AyRmshu51QU/+l+wOjRPY7mONPx3KMkrPxfmNLi4ICkK3bSWVKetg
         z4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708165665; x=1708770465;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6wGmVKMUMPFGBDWK1cKr8wVY2QYEjHS28FhJFBjkZo=;
        b=sr0igaKpUniJaaGLT4vEIpS0nrSbXM7HkyLde9Z880H7SsnY4zy/Cng0YUiHfCJLmd
         MnMptkEfxSJJwoe/EYCflM86ybZpM/XYuFYg0pP89l7TePmlfeLJ1MCFjxLamGG0dwJY
         r0sgaioGBu/9R0f8oxhcyS6NHeZ6KQDtmvi7OnnlZx16QlEzl2qQw2+WWTbN2ofSvjC7
         jbjH2xdQMR43euIDy9nx1YgDqxKoiUaL06XW/uU51PjxfXQCJs3i3UOIVgpcbaJ8+StV
         S4JcEz9R1Iee3ZegmEVf3H/K/hS7+vQsATP+ImMqQglCI3l2c6mDyMyEDWN7If4iTAz2
         E/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkGIYaQLyv9rRK7l8OqDYHr0QolW+qid2naS5i+WwAwsNuzNKGm4M6QqPOIwd9v+VVjZ7JYaBMTo/88NMofuFviqGxceL4OmDC
X-Gm-Message-State: AOJu0YzJCj6iRsj2g8tvjngVMraIRBOJlvv8qu40WK3VLBv/upNR8g7c
	6TeqExHLzgWH/sfz4Jig9CF5VmLDJw6kEW+k1Z6c1U7Hec3aWGdbLl6kc5rT8iw=
X-Google-Smtp-Source: AGHT+IHUeBCCNfOTMT200Z74Cnghv39yumCat7MUHrvWHRWyM9YqqunSXXsBmoxV7HCdaoMCmKKnOg==
X-Received: by 2002:aa7:d0d6:0:b0:564:1884:76be with SMTP id u22-20020aa7d0d6000000b00564188476bemr994258edo.39.1708165665403;
        Sat, 17 Feb 2024 02:27:45 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id y5-20020aa7d505000000b0056200715130sm777637edq.54.2024.02.17.02.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 02:27:44 -0800 (PST)
Message-ID: <b7fcb71a-e3bf-4f50-89d6-caff9f3303dc@linaro.org>
Date: Sat, 17 Feb 2024 11:27:43 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dt-bindings: Add post-init-supplier property
Content-Language: en-US
To: Saravana Kannan <saravanak@google.com>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGETcx-tBjfaLQqmGW=ap2N5FLK_gvTzxskA6sVsr_SUEpvomA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 00:32, Saravana Kannan wrote:
> 
> Good point. Done.
> 
>>> +    # One or more suppliers can be marked as post initialization supplier
>>> +    description:
>>> +      List of phandles to suppliers that are not needed for initializing or
>>> +      resuming this device.
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +      items:
>>> +        maxItems: 1
>>
>> Rob's bot rightfully complains here about invalid syntax.
> 
> I added these two lines based on Rob's feedback. Is the indentation
> that's wrong?
> 
> Yeah, I'm trying to run the dts checker, but I haven't be able to get
> it to work on my end. See my email to Rob on the v1 series about this.
> 
> $ make DT_CHECKER_FLAGS=-m dt_binding_check
> 
> The best I could get out of it is a bunch of error reports on other
> files and then:
> ...
> <snip>/Documentation/devicetree/bindings/post-init-suppliers.yaml:
> ignoring, error parsing file
> ...
> 
> I also tried to use DT_SCHEMA_FILES so I can only test this one file,
> but that wasn't working either:

I see the errors immediately during testing, no special arguments needed:

crosc64_dt_binding_check post-init-supplier.yaml
make[1]: Entering directory '/home/krzk/dev/linux/linux/out'
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/post-init-supplier.example.dts
../Documentation/devicetree/bindings/post-init-supplier.yaml:84:12:
[error] syntax error: mapping values are not allowed here (syntax)
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
../Documentation/devicetree/bindings/post-init-supplier.yaml:84:12:
mapping values are not allowed in this context
make[3]: *** [../Documentation/devicetree/bindings/Makefile:26:
Documentation/devicetree/bindings/post-init-supplier.example.dts] Error 1
make[3]: *** Deleting file
'Documentation/devicetree/bindings/post-init-supplier.example.dts'
make[3]: *** Waiting for unfinished jobs....
../Documentation/devicetree/bindings/post-init-supplier.yaml:84:12:
mapping values are not allowed in this context
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/krzk/dev/linux/linux/Documentation/devicetree/bindings/post-init-supplier.yaml:
ignoring, error parsing file
make[2]: *** [/home/krzk/dev/linux/linux/Makefile:1424:
dt_binding_check] Error 2
make[1]: *** [/home/krzk/dev/linux/linux/Makefile:240: __sub-make] Error 2
make[1]: Leaving directory '/home/krzk/dev/linux/linux/out'
make: *** [Makefile:240: __sub-make] Error 2


https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/

I assume you develop on some older trees, because both next and v6.8-rc1
work... or standard issues: old dtschema, old yamllint.

I am afraid you do it for some old Android kernel... :(

Best regards,
Krzysztof


