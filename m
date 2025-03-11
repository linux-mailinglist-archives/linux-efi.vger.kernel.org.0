Return-Path: <linux-efi+bounces-2961-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E48A5B982
	for <lists+linux-efi@lfdr.de>; Tue, 11 Mar 2025 08:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113A1189288B
	for <lists+linux-efi@lfdr.de>; Tue, 11 Mar 2025 07:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452791E9B15;
	Tue, 11 Mar 2025 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2r4fTxd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD2211C
	for <linux-efi@vger.kernel.org>; Tue, 11 Mar 2025 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741676616; cv=none; b=ZtNHs7dGft23pimjoT2G8Me6SzadMRHuOVYEgPHZb9j9dbxSh7dixYNTMgzLOQuLq4mubGm/RrtYoE4+2Nt6RGkaqHh6h9m5GbE11Q2B4U5zAwtz/5kFrBQ9Uk9KMUTYJbe/4AZLzSjOA3O1AQLCC99dhbJ8VShElRgsqOKBy5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741676616; c=relaxed/simple;
	bh=uerust1A6NxNTBMmxvv9O4jU6fUc72IcDtV9mlnkthM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjFlqzgj/nyvJVTCwO+gLddVosHOpQgPwBC+WVAXxzUmutH56bMrZm1LTUo79POl8t43tOEMe6ttTBbdHeKRrE1p1LKUwTd7bYIQ3dRvP3odyqNMQ8fkLtSkJ2WxjKBQufMLE0Z2bEzCqwUlXi9Fw3iJt2Q+sRalxkdSni36nfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2r4fTxd; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fead317874so45154777b3.0
        for <linux-efi@vger.kernel.org>; Tue, 11 Mar 2025 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741676613; x=1742281413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uerust1A6NxNTBMmxvv9O4jU6fUc72IcDtV9mlnkthM=;
        b=c2r4fTxdomyF7Iy3OAcIfvWyhKcGUYh6721PSkviz09nfQ/Lq+6usEpfbZAMYzarf0
         82/m3sKUsrlRXwuHMLQKS1WRlpOI8AGPkY0w/dLmfbfIHaLksmTvi0Ho3yo+A38vbYL4
         TqGec2Se8Wm/3lZT/KEnGu9khjfKQnUbf8Z3iO4an7JVTz1+InqLD7XUr3wfCWDCej57
         D0nZBpeuy1tMc3s8qKwxNUpQr2Rl01EShETI7BmWTFQ2L0QDFb6JTukMCWCZT9GxIVDp
         lS98egUjkep0Tvo53yE6NgZEmDupKh1NGiuCJ0y39jDiuM+4jzJKH5I7hGTDp6AYy43K
         7mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741676613; x=1742281413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uerust1A6NxNTBMmxvv9O4jU6fUc72IcDtV9mlnkthM=;
        b=h/1pO8u/fxXkOrSoyUg4qjMHBZJx/3wRah6XXhhfT3M2K2izK62O9XV9ERaecL9s0E
         zOkDUg2L14NRxKiR6uzKKQAeIBUW0cIbXVv2GZUQdgIDI86qZc5xbr0iBjJpenFbTNjG
         YIJipf9hO6+tMINbVky8qUsHLZ/mRi2Lm54936ow8aGGGDf+tp19uegoBDOoJbRqgczn
         MqxHvgJiroVRDK5g83jR6tNvERcYWXgGdh/46TQEFIwg5LyJd7eiWUwKc8BopC+hFkWe
         26PNTKth2tCCkvlNaY9KaEC3RsI8OECUKJkxgyjMAsHWb3SVQ8uULahDri9ZuK6k5AI4
         xTMA==
X-Forwarded-Encrypted: i=1; AJvYcCU4T62IQTQN8L+8hOFPRLQmSpsWmGFacmmc7whU24aiZAruf5Od1MjYgVkqOxqnEyIb3BPhZCYf3iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVvG4mBd1OmyZbMVVq/LAJbPLN0MRiUSnZBmzVhlMU5aWCyj4L
	J2ojozLsWo4BLLmc66bK6jfILdVztOoD7nMuogDYgAKSgt1/1Pbws55uZqHV/dQ+Pu78ctyVWVj
	ObuJLCdqxTTyUgDWdC7INM6IrNF4V55BIP5TFZWi24VM2pbEkodU=
X-Gm-Gg: ASbGnctWBDCIsa3yUDwoF/QvoOpRG2TS+RITVIM04DZrAkypFsvbrMztHuuKV4BDqZZ
	KIuyY2+w54/EibKN3xu/xph20wXmp2oG/1wJ7uDdSWWL7RzaveikR++V7HXTrK2GgWIRysdWZa7
	ecbaNCac8SDt5/0uRS+tbpBNqIJN4=
X-Google-Smtp-Source: AGHT+IEEOfjd89aRsy1BWq0Nw/uLhKChtJdb7d0ubfG6OfN2lEenJkWImMh8Nc9wi5s6juHA02saIUzqgeqigmRzQjU=
X-Received: by 2002:a05:690c:6c02:b0:6f9:50aa:8605 with SMTP id
 00721157ae682-6febf3e1a06mr221363057b3.34.1741676613476; Tue, 11 Mar 2025
 00:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5BK24Nc0mA4pe8BFp-FUgN4Q9lCFpR1TUFMKB8mRUJIhOG1hP3yYcVIulRsDSQA_7MvOOH9dg1nUiDvQSkQ2tS1vZeiZbMEFEnsMbPzB0cg=@bens.haus>
 <CAMj1kXHN4qTTUzCUvERy1iZVMy6jQ_-iha0EyHBsE5jH0_WaUQ@mail.gmail.com>
 <YT8Nabg2mhqfljPaZg1ruLmAwW-C6iNOaSA4yUC3h8tkwEgaHJswhIP0fKxb_0Tvmsc6muBWW7TRgnCgXejXrXZ5zxx8gMc1aMFZW0A8-v0=@bens.haus>
 <CAC_iWj+LdNXYO-nTzenCvhQN=--hmfJLzH1w_D5g676_6wQ8=g@mail.gmail.com>
 <PkBypGXyjiJ7T845148vEiHaoabJOyVg26qTLI-SygtRbQ9aQjnMWUddWHiYB9KPR8JVqDFQ1pZRnRUq06vIRR7L4CDLERwJL9-2LdvcxBc=@bens.haus>
 <CAC_iWj+YFNMZZneaQ+zh3ziM2iogB-whRsH81A8hKyNVPY0H9w@mail.gmail.com> <CihxtexZ2w9qfxFQ1v6_JhRD4eYGMDbKtlXqd7KTBfgKhNif3Qq3yaJriSzdiInTiywwgk-CxDDPCYqRPdfYKK3hf93yx774aFfjJKeIhs0=@bens.haus>
In-Reply-To: <CihxtexZ2w9qfxFQ1v6_JhRD4eYGMDbKtlXqd7KTBfgKhNif3Qq3yaJriSzdiInTiywwgk-CxDDPCYqRPdfYKK3hf93yx774aFfjJKeIhs0=@bens.haus>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 09:02:57 +0200
X-Gm-Features: AQ5f1JrnzzgjFvZN5leAcDUPZCL1M4Ffq6lQIediflRnb18A6zU5x6AxivCqzjw
Message-ID: <CAC_iWj+9DNswD7qCc7V8UxsAOaBTzx7QTYA7Yo8py5pEuHdWDw@mail.gmail.com>
Subject: Re: efi_random_alloc() returning EFI_NOT_FOUND
To: Ben Schneider <ben@bens.haus>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ben

On Tue, 11 Mar 2025 at 00:03, Ben Schneider <ben@bens.haus> wrote:
>
> On Monday, March 10th, 2025 at 12:44 PM, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>
> > Can you print 'target' in both of your success/fail cases...
>
> For the first (failing) call to efi_allocate_pages() the value of target is 0. For the second (successful) call, the value is 88080384.
>
> > ...and also apply the patch below to u-boot...that will print the memory map.
>
> For the first (failing) call this outputs:
>
> 7 0000000000000000-0000000004000000

Ok, this smells like an lmb bug in U-Boot. efi_random_alloc() seems to
be doing the right thing since it requests memory from
EFI_CONVENTIONAL_MEMORY (which is what the magic number '7' is). Can
you also print the size to ensure the requested size is less than
0x4000000?

[...]

Thanks
/Ilias

