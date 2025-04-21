Return-Path: <linux-efi+bounces-3400-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AFDA957AC
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 23:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14913B00DE
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818A020E030;
	Mon, 21 Apr 2025 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="dKecW/Vz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D6202C5A
	for <linux-efi@vger.kernel.org>; Mon, 21 Apr 2025 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745269261; cv=none; b=lQfrYZV/R8TkhhQiXGyks6NZR7ORF/TnWYCb8pw4bUNyjMQZqAyrZbC2C3cZks1CcU2u+kSm2jf6sw1vVhFLZAYYt/BVQV6DPQAgcS8RFx3KTWWYlBwhW4FhYMqYrEG7zj33pseTWdLTpUuJtIyaV13cZkRrTssksBwMMZzJ2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745269261; c=relaxed/simple;
	bh=t0reQejpEy+awsYTb53wJTJbKqsU4iiO5Emdqd80b5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2gm3+VSqeqbuakKQXTL2niPzzUo8pJ5Yk1+jWT+eB5u/FwbvUM0F00c1Tvtd23MTl3ALHfSY320zaTug+XoRPHqUHG+uGfm7B0+IH4LApKiDdGOEZw2QO8nsGal0OGfrkGiKAiY8a7bNGQSPEc+eaVmL/4ulO2szUaRWffCbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=dKecW/Vz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so51400915e9.2
        for <linux-efi@vger.kernel.org>; Mon, 21 Apr 2025 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1745269258; x=1745874058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t0reQejpEy+awsYTb53wJTJbKqsU4iiO5Emdqd80b5Q=;
        b=dKecW/VziLc/w0jqpdp4qJMXiFKlfT1BHWF+iC/hH3tcBd2ig16irXyNLZuA67QWKv
         2rAmInde9YHDowejHpcfNjooGw0wIen65ek5zBw8wq8aEM3CHeUqKpZrmjBgQ4ONo+73
         nOHSa8VdaMbfEVud/s+keIh7/cgsjITKplv6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745269258; x=1745874058;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0reQejpEy+awsYTb53wJTJbKqsU4iiO5Emdqd80b5Q=;
        b=A9QuKNfjqbb/a4InZ4/E/Y1Ima/P9Tb7DvofHuW29nLA8LthKJf8XU+zZPelRO+SUv
         1G04qTRSyePoUCK6odeLixKQjtAp9iectYEUukB3+NPYXpJyl+e38bQaCYRtTiyOf+wY
         SscqRKCD0MxzjGgBxy8dandxTsjGhwOysIi08XV/a1DrPRxcYSBmT2I06WFSPUrM9WHX
         DwQtf68nxH2NZlU8iGvijzHNOaSd+uyQUD9XJ17O1UlHhdoISJL5nWRkewgA+Zz1S1Yg
         SOhOoVNCBwsK5y98SuboEhKLAViKi4mesmt2kOzUYsDnsiM1tLD7nDBWKtyXtF3AqaBu
         hCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiUYJt9VdH7JgHIc+ajpy15t8WKpRgRm5gKecyCImQPc0vHS59rb0nzLPaBrm3o/PoNV2l68QzVtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx5U3fjL2Kd9Ks6l0FLFHNfbbs6rYRIkjqKe+99L2oUfnZH+S3
	UDlJttveNHkYF0WZpjBLgBzINpfyzy0LvISh7hAoqKp4Y4UKra2P+5WJgR8pYPo=
X-Gm-Gg: ASbGncuBsOuKCAXSN3pBfJEj8iGgh8FxEPMZHtBPwQfj6c1dPGcmiCyLNsgmiSABRe5
	l05leLXXt5/K2LvgHMCESAz4s9LOgXqkVJjeKUjMgFNHF+vv1Rlb0DgGjWv0Ojb05ChW1YRbbu+
	UrNsfIRtuA7nt0N3xacsw6Ng6ZsfnRXUKySGhPLNkrsVUxd1bzmXAIRrgkUlVKw46g5WhJaL6i2
	Q+aJdMtYIlT1qALuYX/qZlB2GMupDShnyydmMe8isKE9Ymauea3PAjscEJ7AZSxD3rFI2hLUuos
	yA7Ru1Mj4aah7+YN38HdTm9/5HqLbOuK6VvrxqJm2u3pe/rg+MQJkw==
X-Google-Smtp-Source: AGHT+IEqZcEurBsEwpQNvMEBz98hVptC58D9hX1qopJkxrFk/Vkqpzpoey4oDYw4HKljgsecLmBIZw==
X-Received: by 2002:a05:600c:1c12:b0:43e:ee80:c233 with SMTP id 5b1f17b1804b1-4406ac20146mr103140445e9.32.1745269257767;
        Mon, 21 Apr 2025 14:00:57 -0700 (PDT)
Received: from [192.168.86.29] ([83.104.178.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acc5dsm150288735e9.9.2025.04.21.14.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 14:00:56 -0700 (PDT)
Message-ID: <693a7733-0e03-4236-bdd1-13441b1ca3a5@citrix.com>
Date: Mon, 21 Apr 2025 22:00:54 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Dave Hansen <dave.hansen@intel.com>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <d96f9c5e-64ed-4c28-a8ad-e22daea19742@intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <d96f9c5e-64ed-4c28-a8ad-e22daea19742@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/04/2025 9:52 pm, Dave Hansen wrote:
> On 4/21/25 09:26, Ross Philipson wrote:
>> The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
>> enhance the boot security and integrity in a unified manner.
> Hey Folks,
>
> It isn't immediately apparent what these 5,000 lines of code do which is
> new, why they are important to users and who will use them. I've
> wondered this from v1 and I was hoping it would have gotten better by
> v14, but alas...
>
> Purely from the amount of interest and review tags and the whole "v14"
> thing, it doesn't look like this is very important to anyone. Not to be
> to flippant about it, but if nobody else cares, why should I (or the
> other x86 maintainers)?

The very-tl;dr is:

This is an implementation of Intel TXT which isn't a piece of
abandonware with unaddressed CVEs (i.e. isn't tboot).

AMD and ARM support of equivalent technologies will be coming next.

~Andrew

