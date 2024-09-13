Return-Path: <linux-efi+bounces-1747-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6321978713
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 19:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518E81F21C4A
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F207347C;
	Fri, 13 Sep 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArmW8GEB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFF5811A
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249522; cv=none; b=EN+D9lX37305452aBeI4411K3yGqSqoi3aMfxMH0xaF8PASObrO8dhr/39aHRCLCE/AtXvuJQdXwlqwqrWZFCO1toVtnrPNfibFtpLTG0QFXZhj+bsuvgSdgrRd+hoAlYWOgXM9ZqY73tAiQ+g6tQD9IYQsMgYi5GR6stkP2OKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249522; c=relaxed/simple;
	bh=uerQiA25REcUdMlbDX+xd8ODk1AJUyFQWBwL/FKSagg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b85SdBpPW7XQndyjPpjtHIKELZd8tZZ4xxfSWIh90ZsQlYxACLlb1iooM+lekZ2+97pSp/kTAATDCc+8UzLll93aTX08gKdsIUnd/+wJLHf6ucgXS4UUrH0lW4SfVkIv4mlek9bvDP2npz1fXH5cvGlrcZ+K9rqTAo/tq6KbPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArmW8GEB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53661a131b4so1700402e87.1
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726249518; x=1726854318; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uerQiA25REcUdMlbDX+xd8ODk1AJUyFQWBwL/FKSagg=;
        b=ArmW8GEBm9KEuHb9xwDj3DQZ487E0e6vfFDI2XYzCi82kBofOJO/8U/ILIv90m5sop
         EZIn9/xRKz/4+2Rxh2CG+QKxlVena4eAJw/8Q/rCtEnmsKSaa0xZOxyDq6ZC8HjaNZRX
         QdD6IjuwaW6NB5iyYa8b5DzUIhFIhW28upu/gdbFMiLdEBKXg5eNuJ7Ur4dfNvc63I9b
         SN/3Hb+oTzIH7h9C7mZ/1H3TJMKqaxBSjcPZrHM1WzBW5Zrm/WWePm1gp+o6u4gw2Kfg
         9mcFQ7jJQdopiV05ZzY0kRgRlZJSVXP8g6WpCWvOZ9SlGUdzCTnvSpPoX1qb/RsCsP4O
         JXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726249518; x=1726854318;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uerQiA25REcUdMlbDX+xd8ODk1AJUyFQWBwL/FKSagg=;
        b=D3VkfaVkYn2+zmkglU0NCLtyKg3aXFYstCp6TIwTBLGHAPjEfS2fLzyYMBxFVFr88z
         3FKiNf6SKTzK+o+YcLih8MMU8oRdXAbthdNc5YkuqzIAIU0HSM61cl74379YfLpL07k/
         tm8M61m5NAvkaaLmimMaqV8RN2CIqzXTsyJkD4lAy+Pu1TPk9Yvs6RTw9xgWEr8+4fzc
         WrhcaD7GEbkuEZfs+kwZtcQHbfIfttlQS9DvHfWFhsFTAWmH+2x/gjXjlMLbYiwvblMW
         fTfyvkDsb5u/IoPbQUiCimEepAgOjqdt0PVfBnv9hNR6KAroI3aTZaZsh8tEkKuxgyO2
         hFrg==
X-Gm-Message-State: AOJu0YyPTOtS1YxGlm6fKNAkMqe62GPqsU1UfXVEiAsDpziUdFdN5gNN
	1U8bPOQzVquyqNf4ymKRiINxaw4NgviBqWPzIa8rqlCHhKpSmq4ROK6U7ilwRePJIyaRSJ70jbw
	zDEC8kGfa7Vd1ZFQxnBP1gaxSoH1q/wIy
X-Google-Smtp-Source: AGHT+IEsVetx3jTOpuhyNUUSnx0cFH/f8OwaWQCGOa6Xaz5R5Inc/PSGUkP9zDvsWSgwFCp0gD/FiUyvwodECaefRDg=
X-Received: by 2002:a05:6512:3a95:b0:536:796b:4d94 with SMTP id
 2adb3069b0e04-5367ff24f14mr2595033e87.41.1726249517925; Fri, 13 Sep 2024
 10:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ofthecentury <ofthecentury@gmail.com>
Date: Fri, 13 Sep 2024 22:44:51 +0500
Message-ID: <CAOociT5+t6gDTDguVB0M6mAwnZwgAEdJZH3-63O5O=1c_t6Hyg@mail.gmail.com>
Subject: "No EFI environment detected" debug message not logged
To: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have a question about this: efi.c file:
https://github.com/torvalds/linux/commit/7c4146e8885512719a50b641e9277a1712e052ff
I see "No EFI environment detected" printed on screen before kernel
boots, but I don't know what log it's saved in. It's not in dmesg, not
in journalctl. Is it not logged at all?

