Return-Path: <linux-efi+bounces-597-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A402285C162
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 17:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC431F23809
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 16:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947BB762C5;
	Tue, 20 Feb 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atQRrkJm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEDE763E8;
	Tue, 20 Feb 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446520; cv=none; b=VIb3zkPmXvqInDAThcGBxILKLrR7k5z2KPF6Ch+UOsk/uCYKuwurUveH29qg00Vjlyxo2hYcZw3+SlfxwLLd1wZGu7/XxWpdLAqYLFt7AmzUqfDxbWuphbJkyK0XpoGB3SLk9TpmHNyZMItjsrqx++KIqbP5nx9XLVDm+CLawTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446520; c=relaxed/simple;
	bh=W6ryAcfwZgU2CW0jw3zDgVkH2c4/1d2q8S8A2qPS9gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seOJCXVorBoiYM530/g2lfppuEcwKZu7YHlA5tIHLU+U6J9iXzA02fasI+WDSmG5G5qWGeYTHTj7mBG1T3Y2VzguDqJgThv1BRVZvkKR1l5iisAQOvOxZVFdYlw3FlX9yrXHfstDNoTPOJ5nqmG/iBKNURQsl38JW3K+NGPlkl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atQRrkJm; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68f9218e777so3727056d6.2;
        Tue, 20 Feb 2024 08:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708446518; x=1709051318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjGTnWRy8wicbi/6hD5b+oySTHtfpKaKjEocn8v4DOI=;
        b=atQRrkJmRc7jYPKAzMA7E+DJ9j6aS9yEC2u3h4NiQPALlk2uYmcFoy9p9tMy/fcWNN
         qj5PUa+AMbQzt8WBz583kibo1hmx2uOWSsSnnZcKKGYhKIyuyP1/elg0fhdPHmYZyxzE
         Lp+C4r13JLO/FC20q8jIJ2osenflmPR7C8nkTvBl72wOrMhVGFJKl3LK6SewTc9rdtqr
         SP9IVKZeP1Qow/Lss7djMd9mYT1qMlzmvNzwCrfVnj9wBiZz+7Xi44Ezn/5v4rla64U7
         61DdOslFNCLftwz4d4a0tewSxvJiXiHZDsaNL2i7RLv2dfeXMrer+v9t3mm/HySgWuWb
         d8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708446518; x=1709051318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjGTnWRy8wicbi/6hD5b+oySTHtfpKaKjEocn8v4DOI=;
        b=MOVnrwfTHSigGYPLGoQgpaGaq8JAzBUdFMi0Z6kk9POtm1QqyU4cf1CIqVUH9WPKcl
         knQ2lVMxHfuiJKmVrLhxAz5DZkfPnl6oFpekv69CC1wiG1zA8FgJXrVs/qpsmMWo77Ue
         62S8CmmwGi2hKHADxJOjtO06uis433sbldzTbeVsE2LB7OhCfSRtxEny0Gju22PMqc+K
         78H9gCr0pZYpkM/RfeTDKsfW28AvU8dw0hiCofXtzLkiLWGDVHXPmPdujM0Lw/t0cv4Y
         dEIe1GJx1r9vuzl5PYIz6+2qZezLkPamRsZSnUvX1O1OtJNpxDhgB662C8tKWpA3+ZJY
         8d+A==
X-Forwarded-Encrypted: i=1; AJvYcCXIkr3Vt7XOxzRcErM0JkAQ/pMU4r5SQ6OTArdm6/FVtzREJwaFtYHUiX6HGSX7K++0y0dcgWnalkR0M5CtFc1iDOmuKGo+47aPLboz1pTxwrK99QPTUdBBZgsfvtHMo7sfjt6fBwTtdAmK4fvn2XQNwM+l/NHap6K836Q3uiKr
X-Gm-Message-State: AOJu0Yx0W2KszmWA87cKj78inj12GFsXkFAHvvoKqEqlBqv30N9P1LZQ
	AbMz5UQhGOWOvdfq2bmqodBkF3jzThSzOamUdlRmIqQhB5DR78ED
X-Google-Smtp-Source: AGHT+IE6O4Z0wvE9uz+3RViiYkDjcP1LoY+8Nhv9n+YsyZzQC3zJkZQoeaXnHlgX6VmjrbV9VP4UeQ==
X-Received: by 2002:ad4:5aa7:0:b0:68f:52a9:3b24 with SMTP id u7-20020ad45aa7000000b0068f52a93b24mr9074867qvg.29.1708446517828;
        Tue, 20 Feb 2024 08:28:37 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id oh8-20020a056214438800b0068f5a422773sm3382230qvb.14.2024.02.20.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 08:28:37 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id C7DBA27C005B;
	Tue, 20 Feb 2024 11:28:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 20 Feb 2024 11:28:36 -0500
X-ME-Sender: <xms:NNPUZYVOp_2WAKCu9iT1fzWiLDzjhbTOVhiJZcWYSKt-FNPUyMBjpA>
    <xme:NNPUZckIWlEWDbE3vxShV11YGKn8XiRdywYJOq-Tzs4k2pkzeBeVtKGAvhgzemlKA
    golRhlKc1RYXDkz9A>
X-ME-Received: <xmr:NNPUZcar5uWo_lQYHifGbz9xrE6poPVPp_CW43CJkuLZ1MfpkGXPYz7C6GY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:NNPUZXVz9nQ1IMrvEwbsqtqT7NZqFUWVtuxz4Exg6RcTSPzuyHvARA>
    <xmx:NNPUZSkLylpVwuQnrirN7tq8yXJ5muZzixR5ZGuev8CwRCA70ZRazA>
    <xmx:NNPUZccywIbZSmaYszzCNb5C0CluCDlxkppz31Gb6V_7hHiTJMwNwA>
    <xmx:NNPUZUVXa6n-WbCbIF3qy5p3wyRj9Pc1ELdDkg6PAd1nPjQLmAo9hA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 11:28:36 -0500 (EST)
Date: Tue, 20 Feb 2024 08:28:18 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Oliver Smith-Denny <osde@linux.microsoft.com>
Subject: Re: [RFC] efi: Add ACPI_MEMORY_NVS into the linear map
Message-ID: <ZdTTIo6g8kklEryd@boqun-archlinux>
References: <20240215225116.3435953-1-boqun.feng@gmail.com>
 <2024021718-dwindling-oval-8183@gregkh>
 <ZdQmCEepdOE2R7gS@boqun-archlinux>
 <CAMj1kXGzaUsgn0DGfy15c+Z5ECNqosjWbci-YZyUTsMWXte21A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGzaUsgn0DGfy15c+Z5ECNqosjWbci-YZyUTsMWXte21A@mail.gmail.com>

On Tue, Feb 20, 2024 at 09:27:54AM +0100, Ard Biesheuvel wrote:
> On Tue, 20 Feb 2024 at 05:10, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Sat, Feb 17, 2024 at 08:49:32AM +0100, Greg KH wrote:
> > > On Thu, Feb 15, 2024 at 02:51:06PM -0800, Boqun Feng wrote:
> > > > Currently ACPI_MEMORY_NVS is omitted from the linear map, which causes
> > > > a trouble with the following firmware memory region setup:
> > > >
> > > >     [..] efi:   0x0000dfd62000-0x0000dfd83fff [ACPI Reclaim|...]
> > > >     [..] efi:   0x0000dfd84000-0x0000dfd87fff [ACPI Mem NVS|...]
> > > >
> > > > , on ARM64 with 64k page size, the whole 0x0000dfd80000-0x0000dfd8ffff
> > > > range will be omitted from the the linear map due to 64k round-up. And
> > > > a page fault happens when trying to access the ACPI_RECLAIM_MEMORY:
> > > >
> > > >     [...] Unable to handle kernel paging request at virtual address ffff0000dfd80000
> > > >
> > > > To fix this, add ACPI_MEMORY_NVS into the linear map.
> > > >
> > > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > > Cc: stable@vger.kernel.org # 5.15+
> > >
> > > What commit id does this fix?  Can you include that as well?
> > >
> >
> > It should be 7aff79e297ee ("Drivers: hv: Enable Hyper-V code to be built
> > on ARM64"), but as Ard mentioned earlier, this could be fixed at the VM
> > firmware, and Oliver is working on that. Should the situation change, I
> > will send a V2 with more information and include the commit id.
> >
> 
> The patch as-is is not acceptable to me, so no need to send a v2 just
> to add more information.
> 
> Please consider the fix I proposed for arch_memremap_can_ram_remap()
> if fixing this in the firmware is not feasible.

Got it. Would do if necessary, thanks!

Regards,
Boqun

