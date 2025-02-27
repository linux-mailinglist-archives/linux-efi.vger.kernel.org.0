Return-Path: <linux-efi+bounces-2840-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D63A47AFC
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 11:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FE11891117
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 10:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F9522A4D8;
	Thu, 27 Feb 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajZ1sRb4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786491DC997;
	Thu, 27 Feb 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653861; cv=none; b=QBlyempMreOQ0w5ogdK0HObiX/0iG2hZsYXxAEFrfUoy5EgRKqmPvupdHiOkJsY2yeEdUYCTD1RAjPt+vVUdAq3/qltjvO9elhRrBy2p6k6pdw2upX9wzhIukVLTsR5cI3zJ2cOOweEHnijignWtjwm0WOIm+NnqFs3aCrHI8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653861; c=relaxed/simple;
	bh=zKmpACgApZGDf+VVI+CD4Rv/C4u2prcVyBajdqkzEAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMLHJwP9OPRCxgW2EDbcBMlM0t/iGaA5l0Z+kdS/qN7D6V+NO+uLzRJ0rEwQ1oBYsvApOkUQQWuV2VLOZeOUX4vXt7pDw1zn0qBpX09yCwZKwlYyzxkb2K3dWFE1xkvkAIOnGW+UNxu9R07rJ8mEieq4KHr+D9M9Ino5yXSN9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajZ1sRb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF557C4CEEA;
	Thu, 27 Feb 2025 10:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740653860;
	bh=zKmpACgApZGDf+VVI+CD4Rv/C4u2prcVyBajdqkzEAY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ajZ1sRb4WGbQlMkMnR5NUXYlyL3JVy5W/qWCQJQAJL/+jcVEd7DMC21IS5nFWnlv/
	 ptP10ao67t+cs2AqdFrsYxWx4vUZJDGeWQ8bw3gkWFmWLLXHmwcpA7Z7Q3+raxeZym
	 4h47DKowUE59La+k13AyRQns759eEztKNdfTOU0s75K4ga/ZK0Ksi8b+XQQZvtMsLj
	 WRwWypYzoYOTcdzZzhggGU3EZ7WgABGOStkxv/G/wGdF59Re3akC4uk5e5hNMno1r1
	 pp58hZMc7NMGj9ZCORnJBFp7Ok7EOVrBiKs+w8Ma0pA0unj5QO1RcMU/sgsT7jFIno
	 pc2sqwwn3hSLQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-545284eac3bso670044e87.0;
        Thu, 27 Feb 2025 02:57:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDrYV2RD9lGqwvcOBPKecZXHyyCxYfVKLfChMaX6irVnXvKmL9atM6+rB37+TgruV2xut9tB2xLskl0pA+@vger.kernel.org, AJvYcCXnLAKpwC+2DdoT9JqW5DMxlf3v3bJKAv2bIkVRmi3zF87yGQ9msYr0FW3w5tfqQDmSG5Yczsjm4vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy920Fx2V0qC9p/lhvwB6hRPZ5z6yMI2eOEhktXGlLRt5igX0Ux
	ZQCBVO1A4XMW4V5kW3mH2kJKxPyKfKRckXPpHPxlt/98Qqek3wHLm09vHvk/gmDj0TbepPrMCdV
	qKMp10y8+vHcK7fo7CHfwH27b+1s=
X-Google-Smtp-Source: AGHT+IHCNs4mhzQpOJmEg+Z4O/xKEexEtXl4q3kKZgwS/e6iNYNl47Lg0JFc8Q620FD7wUA0kPo2yMqNj/LZfJwKk8I=
X-Received: by 2002:a05:6512:104d:b0:545:2e76:495c with SMTP id
 2adb3069b0e04-5493c57a8camr3793713e87.25.1740653859248; Thu, 27 Feb 2025
 02:57:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210174941.3251435-9-ardb+git@google.com> <CAMj1kXHOqMM5uGxLTYuEf9KrxY5WzYvwo847JzoB-Qa2SN67Sg@mail.gmail.com>
 <20250220124831.GFZ7cknypjWiZoZzK5@fat_crate.local> <CAMj1kXEkkShwDfbwJ5abc9Q+LaqbvTNh1O5rVXy3EW85DdYTuQ@mail.gmail.com>
 <2d4924d6-1ae3-4993-a6b0-aae6f00bab88@redhat.com>
In-Reply-To: <2d4924d6-1ae3-4993-a6b0-aae6f00bab88@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Feb 2025 11:57:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGmqcTy7a8hTxRgeNpLT4tu_660Wx+o0FJbynB-a_ZsWA@mail.gmail.com>
X-Gm-Features: AQ5f1JoT20AKU9XGXKKaeIqG0K4DhE3kTw3XvvmQi-cn5DDU2wPKf39ic3Olcbc
Message-ID: <CAMj1kXGmqcTy7a8hTxRgeNpLT4tu_660Wx+o0FJbynB-a_ZsWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] x86/efi/mixed: Decouple from legacy decompressor
To: Hans de Goede <hdegoede@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 14:38, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ard,
>
> On 20-Feb-25 1:54 PM, Ard Biesheuvel wrote:
> > On Thu, 20 Feb 2025 at 13:48, Borislav Petkov <bp@alien8.de> wrote:
> >>
> >> On Thu, Feb 20, 2025 at 12:29:30PM +0100, Ard Biesheuvel wrote:
> >>> Unless anyone minds, I'd like to queue this up in the EFI tree.
> >>>
> >>> Boris, Ingo?
> >>
> >> FWIW, it looks like a nice cleanup to me and it boots in my 64-bit OVMF guest
> >> but that doesn't mean a whole lot.
> >>
> >
> > Thanks. For the record, I tested this both on 32-bit OVMF and on a
> > mixed mode tablet (with 32-bit AMI firmware) that I keep for testing
> > purposes. Notably, 32-bit OVMF boots with paging (and PAE) enabled
> > whereas the AMI firmware doesn't.
>
> Ah good to know that you're still using the mixed-mode tablet
> for testing.
>

Yes, thanks again for sending me that thing - it has been quite
useful. I bricked my mixed mode iMac24, but that thing is just too old
now anyway.

> I've just added this series to my personal kernel testing-tree which
> I regularly boot on various models of these kinda tablets. I'll let
> you know if I hit any problems.
>

Thanks. These changes are in -next now, so that give some more
coverage until the next merge window.

