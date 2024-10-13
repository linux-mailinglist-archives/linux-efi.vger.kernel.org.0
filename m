Return-Path: <linux-efi+bounces-1960-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A9E99BB3C
	for <lists+linux-efi@lfdr.de>; Sun, 13 Oct 2024 21:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F92D1F216E9
	for <lists+linux-efi@lfdr.de>; Sun, 13 Oct 2024 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A211332A1;
	Sun, 13 Oct 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="SwxOSpZX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F61E335D3
	for <linux-efi@vger.kernel.org>; Sun, 13 Oct 2024 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728847530; cv=none; b=d6wij2b4eM8kuj8jgHfv42HAgWIgM+HErf3K3fdC30LO7/clS7WgTVlBIsco8Y9t+I+iWoRnD73cJwdcuzKaZfbzXafEuVPF2WtpTNbrcxZVOnV6nL3xwwdF+m7Rvj+Z+pWTHatpvJkGa7akyotrnH4z9Uj8HHdvLvcAacPefHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728847530; c=relaxed/simple;
	bh=pXVFMnSbHvGZWIWCxCZxNXJPAsc5cwNlWqgPr6lSV0M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uDttEZd+OUhgHyg3l16rffGHALZ0gUt2W2dgQAV6oCANnL33aC4I5k6m+yzSCZuuzt5fOvYUabvwakn7Q/LWjMUQWhD7hk2/7m0bb+DMwduISchUVBo9ZGcWJkDdd8gxTTTToAGoPmGaHwqBWJ+yl8Oe22Y8GZ0C5YIxqHDefvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=SwxOSpZX; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460464090d5so33940321cf.2
        for <linux-efi@vger.kernel.org>; Sun, 13 Oct 2024 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1728847527; x=1729452327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zrIznS7Q8l18arQCJjGYNCqnOxcKuCFvr5eSQ24gEg=;
        b=SwxOSpZXD4rPWDyQrn39H9k8aaY7KyjhwGr/2t/EsVmEqmnaYix6LoOLiQOgkpiuRX
         azkPqtFZN/tUZOUx0fCeSS6RDpkUykMiA+3BYSG5ikdOXMUdXHUXr1wvn+DSKViDrEsM
         VSMfMQcDD0Wp2hgwWJGhy9T/fk258Jo3nN5+23V/Y8X5hD9OVOKby5M9n52GVTTSLN0D
         LkQ15RFwKf10NbfKz7YS1rNIRUVw5ytL7Lul7NG2hcTjKi0Fnj0qJnXJZHl4zHOB00m2
         e2qtET0xhdajk/IYcRM6clxDkKeP1MbmRbE3U9DLS2zrb61cW8iRBhsB1KdDWMCcQ9Zp
         8l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728847527; x=1729452327;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zrIznS7Q8l18arQCJjGYNCqnOxcKuCFvr5eSQ24gEg=;
        b=G5xmrxhYIuRw6/xQK6Pw1+8jXzw1i6JG2lfMFefjX6OZB3bYlWJx0Aw4bKsdsKYghh
         d9Q+WIZ3rT6p4AdLVjfZ0CwGdmZd+kvdMx7vxrGu96TlHCSnWuuqJ91EGCbfb14A5lS9
         fpvNOKE2KcuYWBfa2R9LGduTaQeSJjRF1NmDs72+z9aDc5M+CZIgq8aCddTI2SJvZoJL
         2oZj75udJh1y2XOx5GZuT1pb88hjQCo/om+i6QVugfcLVdZPE4qfrXqC0TU385gsHVgf
         0Q6uZFZY6BFxDULzhqko1rjVgjCyRakTx3wqRxwBMBKb4kNF+r7f5NT4mS3LkuGW5JeB
         AFQg==
X-Gm-Message-State: AOJu0YzRW/eqeXNRaqC7f6dPC12scxkix8YT6XGmHos9RNXvUbKFaQBZ
	QAz9619QurwWGxrhaE8Y8lwqFKzQ9egp9bWt1DsF7UKS1irRqUNpsPp9iZO/zxY=
X-Google-Smtp-Source: AGHT+IEJNYlsyx8T+jvHzQldZj2f3S8SmxEhhWozD8TMDGZMQODrTJu3Q0sDXFRzrKhgTK03uXP+/Q==
X-Received: by 2002:a05:6214:2b93:b0:6cb:99db:bdbf with SMTP id 6a1803df08f44-6cbf0051da6mr133964626d6.43.1728847527282;
        Sun, 13 Oct 2024 12:25:27 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b695fsm37792116d6.37.2024.10.13.12.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 12:25:26 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] efi/libstub: fix efi_parse_options() ignoring the
 default command line
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, Aditya Garg <gargaditya08@live.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <kees@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>
References: <20241013051239.22564-1-jonathan@marek.ca>
 <CAMj1kXHvOgGysdPSNNk1bUR2f5tzRaxr4=saqF8KFXq+q6gDCA@mail.gmail.com>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <b13dc40b-cb72-02f6-0379-358499696eb2@marek.ca>
Date: Sun, 13 Oct 2024 15:22:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHvOgGysdPSNNk1bUR2f5tzRaxr4=saqF8KFXq+q6gDCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/13/24 1:30 PM, Ard Biesheuvel wrote:
> On Sun, 13 Oct 2024 at 07:16, Jonathan Marek <jonathan@marek.ca> wrote:
>>
>> v2:
>>   - changed to check for NUL character instead of size==1
>>   - reworked cleanup patch to remove cmd_line_len
>>   - moved 3rd commit out of this series
>>
>> Jonathan Marek (2):
>>    efi/libstub: fix efi_parse_options() ignoring the default command line
>>    efi/libstub: remove unnecessary cmd_line_len from
>>      efi_convert_cmdline()
>>
> 
> Thanks. I'm inclined to fold these together and just merge them as a
> single patch. Any objections?
> 

No objections (its not important to me, but if you want to get the fix 
into stable I think the separate commits makes that easier?)

