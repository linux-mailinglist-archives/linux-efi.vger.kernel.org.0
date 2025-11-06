Return-Path: <linux-efi+bounces-5369-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC14C3B271
	for <lists+linux-efi@lfdr.de>; Thu, 06 Nov 2025 14:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5815E502F97
	for <lists+linux-efi@lfdr.de>; Thu,  6 Nov 2025 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130932F76F;
	Thu,  6 Nov 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJB+oMwR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE1A32ABF6
	for <linux-efi@vger.kernel.org>; Thu,  6 Nov 2025 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434508; cv=none; b=HmWwByD7vTUNwnze1OTDAMY4exGLKypwi8J9q6rnE8cCLxWkqn//6PnPF2T3FEQwHh2RLCvhAC7axTSAAqoSjmFv5koCiVbLDbL1juDSYgYvKSC4pzAiU3xKZAycEQAP3t1FKI1m8IzAdXJgFL8NXD3AoPQDX8RQWlRsaet2wZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434508; c=relaxed/simple;
	bh=8wi8v4pafiCAVW0LlbviwrSq4+RD7ApxtwSAV0zAito=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ny6CJYar3jpneHLnGGpDn0VBUnsaYLGXHm6nYUzuqoMj5xGqVbeNQafTB5j3Gz9/gCXksX6yiExMX7yIJQreoxA/rbGn5cOPie5yUdYVIFhL3GupTl86E+uus7rQJFZjJWfqL4N+q3TXhsdp/SA/tpIwLAqGqIzI857TucxDYYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJB+oMwR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so1318597a12.1
        for <linux-efi@vger.kernel.org>; Thu, 06 Nov 2025 05:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762434504; x=1763039304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=enqwyA/A3yCA7Wm2D9J7INIOgAB6+/16vEu7wgpBUcE=;
        b=LJB+oMwRSDYLXuRamc4Yk0Gw9JWPilvB/no2q3yEKpNvGkLorI7/qJnepZvbp+uVjO
         JAh4Fv5g5QxkDhU58OGkOQFwgHs6ZhaVX/K3tYx9PPjIcW3N+VGZwgRLO6qSZIUl08r/
         zCH61rkoVO4696u8ICgu8dk64AKzmRZMqQ1Fq5JhkMSPTR54bPZb0jrJecfmfnuzyh+9
         VeizpinU402Z0f6oMfRkwdxgGm9Sl1rHnFatOM00iAHZq1QLTasGaGeL/WlakZOD12zu
         v63XwyjeS/lBOaz30sgqU9yCO58Edu3bilru+bw2dE0g7BllDoOoc9G7U8u8uObfarSj
         uYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434504; x=1763039304;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enqwyA/A3yCA7Wm2D9J7INIOgAB6+/16vEu7wgpBUcE=;
        b=Y3BTX0vvPy8fCGE8PMa3DNhEifHUeFSlAnAbWur8IROD/7gGTn7OG9z3kp83wDA/gO
         AyFkeIJ59qvtjA8OUbzmPOuMkDYgtcrr9kkq0mNuEkA+0UulfM+6yPvYuPrFw5ABZOsq
         DNmkCtHA2b5dagSAMgy9ZaE8N8fkFmX9bL/PoM8ci0USd+gCJZntYzkJVUYbFfyGh4qE
         TbKFGIhOn0M6+GNZ7Q5SmhxE/PJuU6jNXF+BR4vrRRuEPOCICKfIXwChdgSx0nGxQgDp
         C2B9e1TS1XOcr8HA59FHZlC67mYplZlcYnBI4umbM4Ol3bpJIDJfticSEJgqz5wjHqz1
         qfzA==
X-Forwarded-Encrypted: i=1; AJvYcCWf/xtfuo6XngP89CAgvfffvMqwH82w9giP4MSRuL2CYXmkUIvSSbfYaJkiHwCf9TcIX+LdlcaU9Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwWpUvh5gH1wrHuc/va4OJ+F3hB7T0uDSDOa1x8J6BhPHbeGh
	M146HW8JHAVza3LGDqkGm4FCLvF7tXL+2YacQgYEkQ/fUSlfFXZkrmIRzDJ4/WmgoljgLAzU3Nw
	FY+8p
X-Gm-Gg: ASbGncuflXdlfGvpeZoT1cFQvyOp2FXiH/xCJeTbPeKbMvN/B9NQ852QRZ41ls2VVFI
	ISURsXKj3sfypJqki/nULvFXOWplO29OpytNheVPX00wPpVDU5uwuavRTyzUyaJ8JP7svUn8yRN
	Rd5lgMRlcKnUuADmfERv4xtPPkCeT3Tq1NN4nV+8GBHTgDYTfcanE3qwXqTQOpxxqKm1Vs5pQ0Z
	vXwcwrdB/QjRaUb1WMlkB5Pzk7I6OQ8U/TJJkoYmJUFQsrlCCd4JG6Dc9/mTqwnJ0DsLx4O491G
	73iZ24PZxaMiaT6RKp46UrG9L0vfTAQD+SnaCiFDWx1fFlQA/qOlLzXTtfSG1CX7h328++RJBzw
	stECx8iiRio3gscUYf5LDB4QID3gUHxZKpFxL47rF8wttWI4gVPjRnWYjMoFb9GIC++DrNtuA/B
	ZQwZV7fHcodJaC
X-Google-Smtp-Source: AGHT+IFDbNceai8kygqAPsrd4nZO/xDH+qcQBTNTFiNY8JYz+2UNeSt3srq3B3R4fGOrxSuhtxFg2Q==
X-Received: by 2002:a17:906:c103:b0:b70:7d61:b8a5 with SMTP id a640c23a62f3a-b7265603d1cmr729211766b.62.1762434504394;
        Thu, 06 Nov 2025 05:08:24 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c8e29sm208344066b.74.2025.11.06.05.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:08:23 -0800 (PST)
Date: Thu, 6 Nov 2025 16:08:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Francesco Pompo <francescopompo2@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Pompo <francescopompo2@gmail.com>
Subject: Re: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
Message-ID: <68a428fd-aad8-4540-a509-d33ba116b5b9@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102001411.108385-1-francescopompo2@gmail.com>

Hi Francesco,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Pompo/efistub-smbios-Add-fallback-for-SMBIOS-record-lookup/20251102-081803
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20251102001411.108385-1-francescopompo2%40gmail.com
patch subject: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
config: i386-randconfig-141-20251103 (https://download.01.org/0day-ci/archive/20251104/202511040131.8yGeRa6u-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511040131.8yGeRa6u-lkp@intel.com/

smatch warnings:
drivers/firmware/efi/libstub/smbios.c:55 verify_ep_int_checksum() error: buffer overflow 'ptr' 5 <= 14

vim +/ptr +55 drivers/firmware/efi/libstub/smbios.c

d45578057224c4 Francesco Pompo 2025-11-02  48  static bool verify_ep_int_checksum(const struct smbios_entry_point *ep)
d45578057224c4 Francesco Pompo 2025-11-02  49  {
d45578057224c4 Francesco Pompo 2025-11-02  50  	const u8 *ptr = (u8 *)&ep->int_anchor;
d45578057224c4 Francesco Pompo 2025-11-02  51  	u8 sum = 0;
d45578057224c4 Francesco Pompo 2025-11-02  52  	int i;
d45578057224c4 Francesco Pompo 2025-11-02  53  
d45578057224c4 Francesco Pompo 2025-11-02  54  	for (i = 0; i < 15; i++)
d45578057224c4 Francesco Pompo 2025-11-02 @55  		sum += ptr[i];

This loop reads across a bunch of struct members.  We would normally
use a struct_group() to say that all the struct members are grouped
together.

d45578057224c4 Francesco Pompo 2025-11-02  56  
d45578057224c4 Francesco Pompo 2025-11-02  57  	return sum == 0;
d45578057224c4 Francesco Pompo 2025-11-02  58  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


