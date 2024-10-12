Return-Path: <linux-efi+bounces-1944-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6603399B554
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 16:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDCD1F22938
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE601898F2;
	Sat, 12 Oct 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="LiYkiAYk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493371482F5
	for <linux-efi@vger.kernel.org>; Sat, 12 Oct 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742273; cv=none; b=mdN7IqOX8UvIFPdtQnNV2P1BNCulVboJlRcvSXQmW62mRBt1KKUzPR4+CRK0KQNMn8tG2Jp/TIfUrRX8r40uHwMBF+femqLCo1Yqv7ubXjtXRtADrZiwRdhBfXANthGPBXIM+W0EzACIqtt2N2s/tAdzdwHjavDHGhDFs5L1rUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742273; c=relaxed/simple;
	bh=vKIelkdbzjdJSmhqYKlQmWBZ8iWFrRCJDY7RyMoUXDQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZcissNw/MNN894A2YEm+hRRwujBBRJ92xkXhVl8rGAuNmX1A2Tp2Vp1GtVT06hiumsLu0y4Hiz1T18XfpmFmrno8FlI4nzhmxY4IrYkPyhhq9fiSJ1D+UL7C7ig5XdIbwtl0yQsX3UGqici8C2Jhj+nZIYJy4PJTdXAIzc6HVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=LiYkiAYk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b10e0fadbcso223129185a.2
        for <linux-efi@vger.kernel.org>; Sat, 12 Oct 2024 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728742270; x=1729347070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYQbwUiBKcS0gLPVZjqboA3w83qp/wQEz3Nd5sYHBZ4=;
        b=LiYkiAYkYXushcIAQbWd/hXJag0JSiyrKWSQBtGt4L6cREpzBit3r2RI7jcwYIQojL
         nsP0BNwjggGRzXVkDVEoaSsiWeybNiQ1giC3+iFDxzgkMpRACtul6qOwGZl8YViLcuLL
         SvLhROk/H4NB3PGKmtoof5TNPJUc5Yi3P0X2ebOUsvzhBIMyoCaRXdMnhUTu1yD1tMwM
         SdhkPUEe0QpUrFRITAJTKUPxtBYu6MO/eCegtthbggXq+ms8Q/uo8mOicdOrIacDOBTh
         aqotcH1L8nSbzbZbMOZXbz+aQbIFTJOu9cKYrnkySmQfbs87iVG4Z9cdBVlgBMStJSU9
         AQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728742270; x=1729347070;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYQbwUiBKcS0gLPVZjqboA3w83qp/wQEz3Nd5sYHBZ4=;
        b=WLKYdvztSLFykJwVcpZq9+0GW1oayuRKI9DomZbBan9xafjNTnX4EMeUjOoHCoWBbZ
         6pJCVKfJOz7Gd3ctNZzJU8YRbu/gbuJfDWHk/jSRZvNWX40O7A9w0P6q5jC75P99mAYX
         tXTeZYs51M/ZuHhmCXhMNgjPt3i8677ERxHn9EEj9Ufhvzo4KptCk8uNzbK9Zil+fL12
         +vMYlGtcehbcuNp3R98Fcun/ycjilYODdsDFtCx5Scs00mecIEo+lGQbJPyOrStuQz/i
         qq3Ws+TSC5Eat26XFtpKMBSxb88z2cayy7eWFYxO0IvnAaQNfMRyNcC+y3EPPPzEO7Id
         BKgg==
X-Gm-Message-State: AOJu0YxY58SmRfbUlAP+vnFN0+jhMeLZ5MGbgL4Y+tHm2yL5esK97B8u
	IJbzBrlYyr0ofDfT9ae8w+1xvG9zrkMYuCqSU8mMPzcyJsWkm/tDDOGI6CzhfTs=
X-Google-Smtp-Source: AGHT+IF8BfzJbLBs0XUAplbv0RrinthQzFyiG8dSxJGuojgDu9lDiWoTMC08ApTcv3ds7pcB4Id4hQ==
X-Received: by 2002:a05:620a:4454:b0:7ab:ec86:c91f with SMTP id af79cd13be357-7b11a37feb6mr1071825785a.36.1728742270047;
        Sat, 12 Oct 2024 07:11:10 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148d69f3sm226623585a.29.2024.10.12.07.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 07:11:09 -0700 (PDT)
Subject: Re: [PATCH 3/3] efi/libstub: consider CONFIG_CMDLINE for initrd= and
 dtb= options
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20241011224812.25763-1-jonathan@marek.ca>
 <20241011224812.25763-3-jonathan@marek.ca>
 <CAMj1kXHgFVs5Gt5hNao6DTZxqw4dO89OuUMH2tvdWPY1kxfc0Q@mail.gmail.com>
 <acdd3e0d-8ce4-264d-2328-05e7dc353817@marek.ca>
 <CAMj1kXFe1ZYuR=45VhwMyHcZhSTQVwLrbZDWpgG7Zqw+Awws_A@mail.gmail.com>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <a6d0d8ae-3cd0-9888-abcd-1db5ab1df011@marek.ca>
Date: Sat, 12 Oct 2024 10:07:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFe1ZYuR=45VhwMyHcZhSTQVwLrbZDWpgG7Zqw+Awws_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/12/24 9:36 AM, Ard Biesheuvel wrote:
> On Sat, 12 Oct 2024 at 14:04, Jonathan Marek <jonathan@marek.ca> wrote:
>>
>>
>>
>> On 10/12/24 3:54 AM, Ard Biesheuvel wrote:
>>> On Sat, 12 Oct 2024 at 00:52, Jonathan Marek <jonathan@marek.ca> wrote:
>>>>
>>>> Replace cmdline with CONFIG_CMDLINE when it should be used instead of
>>>> load_options.
>>>>
>>>> In the EXTEND case, it may be necessary to combine both CONFIG_CMDLINE and
>>>> load_options. In that case, keep the old behavior and print a warning about
>>>> the incorrect behavior.
>>>>
>>>
>>> The core kernel has its own handling for EXTEND/FORCE, so while we
>>> should parse it in the EFI stub to look for options that affect the
>>> stub's own behavior, we should not copy it into the command line that
>>> the stub provides to the core kernel.
>>>
>>> E.g., drivers/of/fdt.c takes the bootargs from the DT and combines
>>> them with CONFIG_CMDLINE.
>>>
>>>
>>
>> I'm aware of that - the replacement the commit message is referring to
>> is specifically for handle_cmdline_files() which this commit is modifying.
>>
> 
> Ah ok - I missed that.
> 
> This is the kind of context that I'd expect in a cover letter, i.e.,
> that the command line handling is inconsistent, and that we obtain the
> command line from the loaded image twice.
> 
> Also, the fact the initrd= handling and dtb= are special, because
> a) multiple initrd=  arguments are processed in order, and the files
> concatenated,
> b) the filenames are consumed as UTF-16 as they are plugged into the
> file I/O protocols
> 

(not relevant to this commit, but I need to say that concatenating dtb 
files makes no sense, only the first one will be used by the kernel)

>> Currently efistub completely ignores initrd= and dtb= options provided
>> through CONFIG_CMDLINE (handle_cmdline_files() only parses the EFI options)
>>
> 
> Indeed. You haven't explained why this is a problem. initrd= and dtb=
> contain references to files in the file system, and this does not seem
> like something CONFIG_EXTEND was intended for.
> 

Its not the expected/documented behavior, that should be enough to make 
it a problem. Nowhere is it documented that these options would be 
ignored if provided through CONFIG_CMDLINE.

>> For the EXTEND case, I didn't implement the full solution because its
>> more complex and EXTEND is not available on arm64 anyway, so I went with
>> just printing a warning instead.
> 
> This code is shared between all architectures, so what arm64 does or
> does not support is irrelevant.
> 
> Can you explain your use case please?
> 

I boot linux as the "EFI/Boot/bootaa64.efi" on my EFI partition. The 
firmware does not provide any load options. This system needs a dtb, so 
I add the dtb to my EFI partition and configure it using the dtb= option 
(using CONFIG_CMDLINE).

