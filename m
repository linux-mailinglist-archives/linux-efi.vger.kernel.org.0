Return-Path: <linux-efi+bounces-642-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8D85F3F9
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 10:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344DB1F25245
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3955536B1B;
	Thu, 22 Feb 2024 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKa4zg18"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC336AE9
	for <linux-efi@vger.kernel.org>; Thu, 22 Feb 2024 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592877; cv=none; b=S3YB+t/aTFAdGGrNVjBkcULCxibbp30Av8vCStZlyAnhpfJHu6w7XDdEBIOYsMfCkqf9BXj/l25KkT/S5oAntuLrs87xoX4baKCwx58Nbi1b5qePmdjAhoaW0P1SGgjBivicuGIYIBVz4oMFQEv0hEJBCoWlb86nThHf6KH6y5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592877; c=relaxed/simple;
	bh=w2YVtj14mJYN/DBHiYMlFojoVgEZJr4yEw2ozYCtueQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aq4fHTMnJE7J/WctRleGqdi294xCipQtSWtmJGH2zfdpv+5WVE4yPIOULqrpBD5Iy36B4EFq9u5jkadmKRe0pMcPRmO6D4g+tbBrMFmIhkkK0LhPgVCiHKSRlGv88NSh0Ll7B+2QL5i/bdnzX0ECYXQN5PiomC8C3xON+WJg5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fKa4zg18; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso8132632a12.3
        for <linux-efi@vger.kernel.org>; Thu, 22 Feb 2024 01:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708592873; x=1709197673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vP/n41qKMmnFZWvtAa6bIMuGiBG2lj2PP2oWwVowhdo=;
        b=fKa4zg18lcr2QWdjIu7JSOWnYzeQBNGo2oOeO519iwPP2jgUBKizimUQmmEqtSoZN5
         nBzeEvLoPVLrwv1U5RKP8buZiX3DdmEk3+9Cv/Qchp5s5EsAsfv5XGDDT9Hcc4o/D5Bi
         DjTFd1SfLwvB7vf4lUygmbdXqJkpoDN0zSMhCnAVuAn1+titStAztZYpxyi6/h7FrSm9
         xoVrBhLMwUPdv+j93Ki5k6NLHXvU1IBM/QqBs9hBVbPInQq7lZ4EPNMKEAWSXf6ocU/h
         hCxein8rC4UAjfl47EuNMBfz7NP02yEXJ+mRSJ/QyGvGGgBHeOZA5um8FnhJqItAkilk
         96/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592873; x=1709197673;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vP/n41qKMmnFZWvtAa6bIMuGiBG2lj2PP2oWwVowhdo=;
        b=k0eoVktGCiUcM6wEfBYbU8e1G0f0aKVlqWSNGKjb+jDxgr2yKMnCqNpbOGfQ6pZKW5
         cKSkwZf9swWKSx3MRjEi/otWMhKZNxNZ9sOhEV4V8xdmwcjex5BrqVgsAsb/Imv3USll
         Ob0npEB43u/SoDLXaXItLfyVxthsvrBYJgGaz8DVfX4QveVHopZqCamWkrC11k8T1M+u
         JxARDYJ9AN1psM3j9aK5JgVPY5NvEvL5wGu7i8XUGBX0Pw0SAftbSKiktG0wEmwPzpy3
         C+aq9bY/LT7neSMdQhz7LRiuOzcFVJ1GPc5U4IY0kUoLpE/JXSIWIeYIMZ4SmxkKGM8o
         wntg==
X-Forwarded-Encrypted: i=1; AJvYcCVObGaicq/k/C5bVpkwNdgUFLXa6uVPxnZTLP3zZkM8/lgYCrlr9KXFoFdgLEYYYINcYBizzb00nkZ1ClqbmBbM2VA2MdfvXk/X
X-Gm-Message-State: AOJu0Ywxds2NhiLmRuKqgtaySkBplXDCt6LIH+15R/RK9nzqwxWii71Z
	Pr9OoFuwtuEs9s4b276Tez+WOj/t5edmwhSQG9tNLfnMlJX+dvBYymsgN3kw/q4=
X-Google-Smtp-Source: AGHT+IGzgmqpsGNjtZpPJAeFzfPQKVvdO33iEfZtGi2PLjQut65szGL8kXE+6IyzFgpbReJ/VQNWIg==
X-Received: by 2002:a05:6402:643:b0:564:65c5:f048 with SMTP id u3-20020a056402064300b0056465c5f048mr8534936edx.28.1708592873602;
        Thu, 22 Feb 2024 01:07:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7dc02000000b00564cb5a3c7esm2195241edu.81.2024.02.22.01.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 01:07:52 -0800 (PST)
Message-ID: <a643d615-e56b-481e-9a15-e0c578de3eb0@linaro.org>
Date: Thu, 22 Feb 2024 10:07:50 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] dt-bindings: Add post-init-providers property
Content-Language: en-US
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, kernel-team@android.com,
 linux-efi@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20240221233026.2915061-1-saravanak@google.com>
 <20240221233026.2915061-4-saravanak@google.com>
 <170856138383.540970.12743608676098316685.robh@kernel.org>
 <CAGETcx9v_NHhC4EwKDQ1UQMQQB=B2e1nQSqJZAwc7VwEWztp8g@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGETcx9v_NHhC4EwKDQ1UQMQQB=B2e1nQSqJZAwc7VwEWztp8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/02/2024 04:41, Saravana Kannan wrote:
> On Wed, Feb 21, 2024 at 4:23 PM Rob Herring <robh@kernel.org> wrote:
>>
>>
>> On Wed, 21 Feb 2024 15:30:23 -0800, Saravana Kannan wrote:
>>> The post-init-providers property can be used to break a dependency cycle by
>>> marking some provider(s) as a post device initialization provider(s). This
>>> allows an OS to do a better job at ordering initialization and
>>> suspend/resume of the devices in a dependency cycle.
>>>
>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>> ---
>>>  .../bindings/post-init-providers.yaml         | 105 ++++++++++++++++++
>>>  MAINTAINERS                                   |  13 ++-
>>>  2 files changed, 112 insertions(+), 6 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/post-init-providers.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> Documentation/devicetree/bindings/post-init-providers.example.dtb: /example-0/clock-controller@1000: failed to match any schema with compatible: ['vendor,soc4-gcc', 'vendor,soc1-gcc']
>> Documentation/devicetree/bindings/post-init-providers.example.dtb: /example-0/clock-controller@1000: failed to match any schema with compatible: ['vendor,soc4-gcc', 'vendor,soc1-gcc']
>> Documentation/devicetree/bindings/post-init-providers.example.dtb: /example-0/clock-controller@2000: failed to match any schema with compatible: ['vendor,soc4-dispcc', 'vendor,soc1-dispcc']
>> Documentation/devicetree/bindings/post-init-providers.example.dtb: /example-0/clock-controller@2000: failed to match any schema with compatible: ['vendor,soc4-dispcc', 'vendor,soc1-dispcc']
> 
> I'm assuming it's okay to ignore these warnings about made up
> compatible string names.

No, unfortunately not. I think you need to come with a real example or
just drop compatibles.

BTW, I still don't see any users of this binding.

Best regards,
Krzysztof


