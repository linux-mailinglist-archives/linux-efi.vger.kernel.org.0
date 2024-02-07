Return-Path: <linux-efi+bounces-493-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1B884C1A0
	for <lists+linux-efi@lfdr.de>; Wed,  7 Feb 2024 02:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F0FB237AD
	for <lists+linux-efi@lfdr.de>; Wed,  7 Feb 2024 01:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA5BD268;
	Wed,  7 Feb 2024 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="rXsEbN6/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914BD27A
	for <linux-efi@vger.kernel.org>; Wed,  7 Feb 2024 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707267875; cv=none; b=tDdhdCEMZtKH3tbEpGU5KxD7S8dGroVrN0PRTgaFqoeMcw95JhSY83EWl0/SVSbexaiZdYYs0qAsbBHISZglbKaH0EOr08t8yLfVTZALSUGUNMD7dsW/dwFdqbG+EqtDflWRilz8GlEuMrkkKazYOSroz8+yaKn7b+s59A6GvvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707267875; c=relaxed/simple;
	bh=tnqp0+o4UjQ9pQtqj33Rbv0wz4gTOgCsar16HtLe8Zo=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=peaQZPoO2o/Ug7I+n+6imaUWgDAkHxsvlJZfKNu8/+byBnYvga8b7L7RS9s5jbWvM5R8wXeYesltU4T94ZXlS+G9kpGdo8Gy87qwXj6mthSi/HtI/5DzgpE8KndFBLUnhkA0Uk0qI3FXXVp+XYDDeYjNlbnOF9ah0hjIR0VSd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=rXsEbN6/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso40237a12.1
        for <linux-efi@vger.kernel.org>; Tue, 06 Feb 2024 17:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1707267873; x=1707872673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KSJRZP7YuqNoUD4atd7Qd4EMeXnFCJPyzasdn7MfZzU=;
        b=rXsEbN6/nhRnPT+AcObKOIIa8gZV4n+vMVoKAE+3yFeVcVUvVp4Orqcjh1S7u2b6tG
         jzQIjHDwS9VbxmlOxwRi2d5LigBsXSBzOjlYaTzdSgmNuPAshoxv/AcqH7k30ROOX4bb
         5ZznYSwb5vMZk2pGbgjhMLQLrtPc7JGxmuM2PcUIeUPDaNCz3BCrst57V9eOoEJtHX0y
         xlZrzIT1E7hxUXfNJcs8VOH3pD8WS1qNRsJyT1G/UJ9PCOhHDAxHL9XEzELCWNrg7bmQ
         Z2XYB4yf1Evr3IqxjEFl3dzamdPa/ekl3MUQfUq8uZBNo46tSgE/m/z2duYn+jhwNd1M
         5PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707267873; x=1707872673;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSJRZP7YuqNoUD4atd7Qd4EMeXnFCJPyzasdn7MfZzU=;
        b=QTAGqd3HBnugBkmEAmXHpxS9VNYuS25zCUu4z5Fp/Y3gPpp42C5vwgsfp+8O9YH/yN
         lcm/TjZFp6L0BeB/QbpW4nNQOLUtFFnXk6XBivkYT29ntT0nS4pU+EXAcbAWtdZNCPlR
         KWnTD9bWRmIJUB+pfiLqUaMqpFWN+YGJbQNq0kFHuK7O/qAGD1ZyiMHzaaA2ecnuDAvG
         0zbVm7cI59ukKt6AHaSNTSy2VaAUSUmYO658/oQNQwWplxJcp++uRMXLQtYnXOKMQtaI
         ZCw+At08qoH/K/qjmBwOq1JECSZhrq7XuK6LuzS/YJ9HegrSBt7wjiah3eHTrUJNfUUa
         x0cw==
X-Gm-Message-State: AOJu0YxjO6eTkGBm8Q2VETVcepGGgFIuSKCjXWLoUgt1ecsR73PVK/c+
	251VQTLmLvZo/ihubMwXczTYI48+5MuY20JmTlcebP/SHJ4OPJVhAzWba4hCQ14=
X-Google-Smtp-Source: AGHT+IEbcsyeWOp+4JdYTl/w+FCuX1Fsyymvn8fUUJUcFSijmo5iCTzMDxF6FQorXgjWWXOLARcisw==
X-Received: by 2002:a17:90a:b898:b0:295:2a35:13b8 with SMTP id o24-20020a17090ab89800b002952a3513b8mr1261301pjr.0.1707267873057;
        Tue, 06 Feb 2024 17:04:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUStYCrR4F6SLcGDQdilqCjiTl+isSJhk9msycAA9AIFOWfBGH7nLE+EP2Q+9bM0HYvysrMJbEuMAt1o4RmLLsAKKqmNiqiO4W9flKqxUsq2W6CiOG3uayyvxdtGWkAgDXi7L/5EHgxs6fDwJ0T17FYXXxM5b0L3Vl2EiVoGHQx2eu8FHmGlmgb8nFLuybkfRJWbAexLNK7WB3ADW1DwAQRp5/23J+d7C163DWM1XGwnTHQTi7dqv5JHw==
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id bb1-20020a17090b008100b002963e682f6fsm2404918pjb.57.2024.02.06.17.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:04:32 -0800 (PST)
Date: Tue, 06 Feb 2024 17:04:32 -0800 (PST)
X-Google-Original-Date: Tue, 06 Feb 2024 17:04:31 PST (-0800)
Subject:     Re: [PATCH v2 0/2] efi: Fixes for EFI_MEMORY_SP memory on RISC-V and ARM64
In-Reply-To: <CAMj1kXEQdGKzoZjaZwa-SRhnwTwvaR_-SY7YtfKsUfEBc952_g@mail.gmail.com>
CC: abrestic@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Ard Biesheuvel <ardb@kernel.org>
Message-ID: <mhng-9698541b-6a15-437d-94ff-3f9e277209ad@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 02 Feb 2024 10:28:54 PST (-0800), Ard Biesheuvel wrote:
> On Fri, 2 Feb 2024 at 19:07, Andrew Bresticker <abrestic@rivosinc.com> wrote:
>>
>> Two small fixes to enable the use soft-reserved/special-purpose memory
>> (EFI_MEMORY_SP) with dax_kmem on RISC-V (and ARM64, I think, though I
>> don't have a platform to test it on).
>>
>> Patch 1 fixes a trivial integer narrowing bug. Patch 2 prevents adding
>> memblocks for soft-reserved memory so that it can later be hotplugged by
>> dax_kmem.
>>
>> Tested on a RISC-V platform that presents a range of EFI_MEMORY_SP with
>> Bjorn's MEMORY_HOTPLUG series[0] applied.
>>
>> [0]: https://lore.kernel.org/lkml/20230512145737.985671-1-bjorn@kernel.org/
>>
>> v1->v2: address comments from Ard
>>
>> Andrew Bresticker (2):
>>   efi: runtime: Fix potential overflow of soft-reserved region size
>>   efi: Don't add memblocks for soft-reserved memory
>>
>
> Thanks, I'll take these both as fixes.

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!

