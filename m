Return-Path: <linux-efi+bounces-2972-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFFCA5DB51
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 12:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87959189ACD1
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A46223E349;
	Wed, 12 Mar 2025 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4RrDTl/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421622E412
	for <linux-efi@vger.kernel.org>; Wed, 12 Mar 2025 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778681; cv=none; b=NyZ6V6tzA9UFtgTMIirMzoT0WNR/+y5ExZUpdMNGla5AGauN0fw3b5V9uJqUKKy+VUDs4DvTRp4Rf0evOJe9ZNtFdyUNQEDVnbrWggaHlph8Cpl2M37K83HJW3mzjj5bspvf5BECz6QZZFUx8SiehGVLzgFXQSzvVLPyWw70j70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778681; c=relaxed/simple;
	bh=IbQoJsd+ZUkNUPdcJPKhUuHvLS/eAqYT7um44t+vXAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dX63MaHJ4nExRHaVQXkaDUf+XlFy/qfwqcxzBYjikEM7uYNLx2HRoL+QA04TCC2eMjZ4ClVCgFDST3bGAJzjd2TaQHscFbOETscoiLnHzq1OiS4HgHoiAJV+weXRt5eqs/E3dKHIyV2SDfm3uHLios+iOxmAJ1EwjiyPPXAPprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g4RrDTl/; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5dc299dee9so5986250276.3
        for <linux-efi@vger.kernel.org>; Wed, 12 Mar 2025 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778678; x=1742383478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoM9ROq7lobBpOV7Fo+L+y29uvKAhLd455oWyaUPAmI=;
        b=g4RrDTl/myICbj9DYL9//SqP3J+MYFLqgWW7k641H0hH+38Sv7gC7rwYCeAZ/OA/LO
         H0lYQcDxzuGyuI/jgNeykCpFS5646V+K1O8CNBrr6TjYLd6fXF7jcOiTIiwsqBDEVuWG
         Am86tAP4mVVy9bQ9jjHfUX6TqJfu8bwyJZpzZXLHpizG/2aNxSYtynQz08sdBfYAEWQK
         JW9WSTqjrZcgJpDi5G68GGWnX4lzEVpXwu8oY9cPWQ9n2sTHfh30TF5HnKGAPa4bJ7rV
         uDAEer7q2FWfN5phzInYxILOPDVMUfiWwdD5v786Qe+bFz6ymzTpuesm7MAjLqNJEFJk
         9LWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778678; x=1742383478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZoM9ROq7lobBpOV7Fo+L+y29uvKAhLd455oWyaUPAmI=;
        b=UFBn2kUfqN+adxRBTyuxTses1UXbygtUhUrd+7kdhlI9btlvd93pbGB8hTUsLT2/zK
         aLLPQxT8q5xcE7rrE0fwB4JxUHazFssczXGJ7HI60dYqLB79/gzdPNy7vf9mW3+rZp5d
         ki2TGwRE8slmRnuxi9Hv0Qt6RUw4tR9vg2xK2hzcK0H/uDyXr51uqIG2zFDA3PMJr989
         uUu64ZVUlGT1f+02n/5BoAvC+RqVbV10W8Rq+xLsVI0s3J6Xn1icoXpLYBhsmuvw7D7C
         x30f2K7jM+J/RI0BCUt3TiuVxfAsOA5z+aiL9x+aYLtg3XP8iT/56IJsq+7X3hjlFq/I
         XoGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF4zG1SekwWvdq0ThBYNtOyw8qW4qj0SN81PXOx/bMHpXT9xmKy9Sj77lnBFiQyDHE8OC7R6IDmng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9WGW9yaylCfgBQfHAz1tf8MsvdVBDZLs9XAQtS2k4otgUBDum
	Vlqp3yO+fVTMp4D+sqJ0TOGzmX12WRliAIW0iQe+k480h3gKlEuEcIVXVw9hinAqi4viF1/OkMT
	gy/VviVd/ZDJgcCbZXIy/pbvuq38D7f0ohIjgjQ==
X-Gm-Gg: ASbGncsRUVjYGUF6vUZ6VDmlSuUsjTIIuJ7AAIQ6+IpluW8Kco/9WxikFDWeXIxFJlR
	v4zg22VFPwdnJTnEf2GSyfR43P+5v8c5QagWx4IVC9vQMx0VWHP/94vhSSdP9+FJ6Q6r6fiF0sd
	tNrKsXWNWedhsOfRkKIrKpxS7J0Vs=
X-Google-Smtp-Source: AGHT+IEXsGKffnDMQnVKgpBzzwY8VoKIq3hO7RsBKpb6xPjlL+R213z5ow5NW/ammvkAw2BS3cXyQPrhi1F+joZ8LzY=
X-Received: by 2002:a05:6902:2e05:b0:e5e:1389:cb2f with SMTP id
 3f1490d57ef6-e635c1f26b0mr28929317276.45.1741778678333; Wed, 12 Mar 2025
 04:24:38 -0700 (PDT)
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
 <CAC_iWj+YFNMZZneaQ+zh3ziM2iogB-whRsH81A8hKyNVPY0H9w@mail.gmail.com>
 <CihxtexZ2w9qfxFQ1v6_JhRD4eYGMDbKtlXqd7KTBfgKhNif3Qq3yaJriSzdiInTiywwgk-CxDDPCYqRPdfYKK3hf93yx774aFfjJKeIhs0=@bens.haus>
 <CAC_iWj+9DNswD7qCc7V8UxsAOaBTzx7QTYA7Yo8py5pEuHdWDw@mail.gmail.com> <gqqWrf3trBPlLLAJDR55YYQBffE1dToIMzSMgebh-GuI-06E3pX4WcYuFU7XOF3s_ZEjK70ePUUJBXu_V0tAxKc8dmNcQjlqR55cLRAHAJI=@bens.haus>
In-Reply-To: <gqqWrf3trBPlLLAJDR55YYQBffE1dToIMzSMgebh-GuI-06E3pX4WcYuFU7XOF3s_ZEjK70ePUUJBXu_V0tAxKc8dmNcQjlqR55cLRAHAJI=@bens.haus>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 12 Mar 2025 13:24:02 +0200
X-Gm-Features: AQ5f1JrPxavB5y2eg5NrtNP7gJDsrPII2oQDdJhRQ2rd_FWXtle3e62EMIn0r4o
Message-ID: <CAC_iWjKL7nSkr8CyFW6hOzfOTiCU+tES_PsEYC7hkcCA9gAp=Q@mail.gmail.com>
Subject: Re: efi_random_alloc() returning EFI_NOT_FOUND
To: Ben Schneider <ben@bens.haus>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Mar 2025 at 18:16, Ben Schneider <ben@bens.haus> wrote:
>
> On Tuesday, March 11th, 2025 at 12:02 AM, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > Can you also print the size to ensure the requested size
> > is less than 0x4000000?
>
> Size is 18087936!


Ok that's interesting.

Can you please apply

diff --git a/drivers/firmware/efi/libstub/randomalloc.c
b/drivers/firmware/efi/libstub/randomalloc.c
index 1692d19ae80f..8073a80a6b76 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -76,6 +76,8 @@ efi_status_t efi_random_alloc(unsigned long size,
                efi_memory_desc_t *md = (void *)map->map + map_offset;
                unsigned long slots;

+               efi_printk("%-x %llx-%llx\n", md->type, md->phys_addr,
md->phys_addr + (md->num_pages * EFI_PAGE_SIZE));
+
                slots = get_entry_num_slots(md, size, ilog2(align));
                MD_NUM_SLOTS(md) = slots;
                total_slots += slots;

and rerun it? This will print the memory map before
get_entry_num_slots() calculates the available slots. Just to make
sure the map doesn't change from the time the slots were calculated.

Cheers
/Ilias

>
> Ben

