Return-Path: <linux-efi+bounces-1941-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5368599B4B7
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 14:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8F4281BAA
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291DF16F8E5;
	Sat, 12 Oct 2024 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="Xt2/rHFd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B51527AC
	for <linux-efi@vger.kernel.org>; Sat, 12 Oct 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734655; cv=none; b=krYDiV3WmSu1dPbGzFAwwND5PESI7JI2z2qWRaGgLSeaVFmwT72e4x6UGApwzWPmC40WaNmb1IOIZ95pKwXg/EyAsw5N6KFdWsXc88xUCJ1pUfzszMBRJnbJgk9zmjpAcsfKI1E827MBA0ex40FAPdpuScNptrXzbsbU+K5KEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734655; c=relaxed/simple;
	bh=noG0YQk4AKAzIpwtZMmmdWIl0V0E+WcBE7c4INGOCBg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=q+Q4UZLEOMDfnSXqmjX/ruuFzr6rYJ13OCjeQfLnXW/X42YLTZnmPARdCQeye7VyI4wjCge0GW4gNPS0xYFiyUlyNUkya8JNHcUR3EMRmWQwvM5+VNBvMUUJtZjPfkshLrSQUCi5cp8o21FJAqLg8wi5ia6LFsKroRjzvYv5yXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=Xt2/rHFd; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7afc847094fso199524585a.2
        for <linux-efi@vger.kernel.org>; Sat, 12 Oct 2024 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728734652; x=1729339452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcvXzTkUD4t3i3Zn8ka0/LCsGo1YvE7yZbwo8Zz+Hyc=;
        b=Xt2/rHFdbgr53QbYLmuIKPs3//64ADAXK035gXTiT9VJ5x9PcFVqJFjRBqNQulVbyu
         hJSXq2apSxNaPbONMBtO7bfKObKWVwsTUA7wYAQIKdVnMVkNL/VwUfwd5ja807hQT8v4
         5T2b2bcl5a4RQgbD+zthEs+J/2Wo1Wi+QhBbGfCR14USFNhKBuvVFqkBTkth4s2J5wt4
         z/Hbbn2kKWLG5N/Kw58hhbbYzGGfvK9iV0V7ybtSCud8g4RFmq3G8bjB4okQDUFbQB82
         jv9aM8ch68yTg2oi7eHvcGPivqgzRTRkXO86BZUZZoONiCSQhMy27wSmpuv9dBGS6EU7
         78hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728734652; x=1729339452;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcvXzTkUD4t3i3Zn8ka0/LCsGo1YvE7yZbwo8Zz+Hyc=;
        b=UQyZQSGQfd7fTYfDOEvi7cdHJcQAGoXoLDi5ddjG5ZNTWiGBs71to7e/yboOxewCYG
         ACdQ79R8BKE3tQ5TR9GKOUcq1kwXI/C5skMpfIA8rGq1yluWYqjieDWZ76f9O/z2qzNN
         yUDi2XuJ5+gyhfom8PRbvGiafSmRn2Fx4x3xdjix60J4SP5E//mfYw8vSFamDrokyOMW
         MoUZRfkjgiGJirUgAeW11kheOMXe7Ay2iUMtDHzrjl/17OSgXULJXy72dX1d4iWUf+oa
         HbTqL+ggLWxAPBYCdTC/5UMvwGPTz9hmhuH7iNfMafkfEdtKvfVtIiljtOg+c1Cr1sH3
         Pptg==
X-Gm-Message-State: AOJu0YxJSng2K4UZQWYmKv859WzjvSEHQACc2ooIlQAlHvguZaTSiSXz
	LgogjstXQT6u95SP5MuWry3EqJOmds+Q4m6KjJl5Ou0/3MabdsaJG1UtDUZSkig=
X-Google-Smtp-Source: AGHT+IGb+V4w4h+7VW2ElzRpArzYr/67eK4xwSv3ABQzrua0zVyHo075Gf5huXn7GcTGGAucSa6wKQ==
X-Received: by 2002:a05:620a:450e:b0:7ac:bb00:cd42 with SMTP id af79cd13be357-7b11a36b4c9mr770216685a.27.1728734652196;
        Sat, 12 Oct 2024 05:04:12 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4604287df23sm24060211cf.67.2024.10.12.05.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 05:04:11 -0700 (PDT)
Subject: Re: [PATCH 3/3] efi/libstub: consider CONFIG_CMDLINE for initrd= and
 dtb= options
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20241011224812.25763-1-jonathan@marek.ca>
 <20241011224812.25763-3-jonathan@marek.ca>
 <CAMj1kXHgFVs5Gt5hNao6DTZxqw4dO89OuUMH2tvdWPY1kxfc0Q@mail.gmail.com>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <acdd3e0d-8ce4-264d-2328-05e7dc353817@marek.ca>
Date: Sat, 12 Oct 2024 08:00:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHgFVs5Gt5hNao6DTZxqw4dO89OuUMH2tvdWPY1kxfc0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 10/12/24 3:54 AM, Ard Biesheuvel wrote:
> On Sat, 12 Oct 2024 at 00:52, Jonathan Marek <jonathan@marek.ca> wrote:
>>
>> Replace cmdline with CONFIG_CMDLINE when it should be used instead of
>> load_options.
>>
>> In the EXTEND case, it may be necessary to combine both CONFIG_CMDLINE and
>> load_options. In that case, keep the old behavior and print a warning about
>> the incorrect behavior.
>>
> 
> The core kernel has its own handling for EXTEND/FORCE, so while we
> should parse it in the EFI stub to look for options that affect the
> stub's own behavior, we should not copy it into the command line that
> the stub provides to the core kernel.
> 
> E.g., drivers/of/fdt.c takes the bootargs from the DT and combines
> them with CONFIG_CMDLINE.
> 
> 

I'm aware of that - the replacement the commit message is referring to 
is specifically for handle_cmdline_files() which this commit is modifying.

Currently efistub completely ignores initrd= and dtb= options provided 
through CONFIG_CMDLINE (handle_cmdline_files() only parses the EFI options)

For the EXTEND case, I didn't implement the full solution because its 
more complex and EXTEND is not available on arm64 anyway, so I went with 
just printing a warning instead.

