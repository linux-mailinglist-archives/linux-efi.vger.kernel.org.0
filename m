Return-Path: <linux-efi+bounces-130-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CB28078CD
	for <lists+linux-efi@lfdr.de>; Wed,  6 Dec 2023 20:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FA71C20A76
	for <lists+linux-efi@lfdr.de>; Wed,  6 Dec 2023 19:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C7047F68;
	Wed,  6 Dec 2023 19:44:32 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B4FD3;
	Wed,  6 Dec 2023 11:44:29 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1faf1ba2219so29983fac.0;
        Wed, 06 Dec 2023 11:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701891869; x=1702496669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INtr6ESdMmvwrLweqn4CnFa4mFOayDNocnS5JvYQDSU=;
        b=wlvDl2haPexeZEg8a6XMFZqY1lF7qOraFwEXtF/+uScFtCGnjMl+KD2eRjnBz0xZoj
         xzVaDJRf/1J4Pu89Sm8BRm+C0isaaGl9rwb6oWkAoZ5s5FZXpWnTL/A0DaPyBYxItVVa
         G0DJZ4LN73//nKSqtySyaZTRRGYT8p/jhrHuSFXpwbRowYjckaM/qGAFxEM3dXwk9iIs
         Es6K2X5EOwezt2c/eeCqU/Rt/MQriwIfqtgy/AxijJpsaju5ejJ73B6ea4F1xTtv05eW
         U0ybzQ4JRVXDYKqo1myXkgdY4KAo4LIh4ivKAWfRBstoaUELoraJhct+EtVv3J11gQXB
         Nbqg==
X-Gm-Message-State: AOJu0YxpDI6R1iMtbMBMmzj5MOBOzmC9In5uiBz59u2sdA9uqEMDf/fE
	HRePGz3sKL1b9XQo2BiJmlMymHjErkFwpWQxd2I=
X-Google-Smtp-Source: AGHT+IGfcNJZtvj9DnCjBMcbliiTnXjZvfx3KHgLDpGuqa+yvHvI5/TJ3VSssAQcSufAtX868tsRqdDp0XR0PnA3RQE=
X-Received: by 2002:a05:6871:d30c:b0:1fa:db26:78a6 with SMTP id
 pn12-20020a056871d30c00b001fadb2678a6mr2734246oac.1.1701891868973; Wed, 06
 Dec 2023 11:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123100617.28020-1-raag.jadav@intel.com>
In-Reply-To: <20231123100617.28020-1-raag.jadav@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 20:44:18 +0100
Message-ID: <CAJZ5v0h7rSY7cD18pGTy9GuNB5s5EvVCNWngPKBtCCXrrNNW5A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Support _UID matching for integer types
To: Raag Jadav <raag.jadav@intel.com>
Cc: mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, ardb@kernel.org, 
	will@kernel.org, mark.rutland@arm.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 11:07=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> =
wrote:
>
> This series updates the standard ACPI helpers to support _UID matching
> for both integer and string types, and uses them in a couple of places.
>
> Changes since v2:
> - Drop __builtin functions to reduce complexity (Rafael)
> - Update tags
>
> Changes since v1:
> - Fix build errors
>
> Raag Jadav (5):
>   ACPI: bus: update acpi_dev_uid_match() to support multiple types
>   ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
>   ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
>   efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
>   perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()

All applied as 6.8 material, but I renamed the auxiliary macros in the
first patch and moved the kerneldoc comment below them.

TBH, I'm not entirely sure about the value of the second of those
auxiliary macros, but then I don't particularly dislike it either.

