Return-Path: <linux-efi+bounces-5737-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C43C98979
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 18:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC783A417B
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFB133890A;
	Mon,  1 Dec 2025 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxW+6ONT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795C3358DB;
	Mon,  1 Dec 2025 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611323; cv=none; b=WLczNzf9mEBo0eJFa0J62e/5m5iVaoipM7OIATjZtMQolLq5J0nPakdAIiO9t2RWHL/HDCDwlNp4ZFZNGqMq3Fo6dGB5JODD/4bcgbIV8zWGnok582Gy2HH1hc+tPicubPhhj84HI4628nRbCODq+mtQl0yC3wTfIopcru3S684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611323; c=relaxed/simple;
	bh=hWOrPGrXp0FSreB+cLgKfrOmVZjwbI7HL6KWRWP8naI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WokGLqL5gV5aGZ+FwjycFuaO4YYsV4mznvl0XNIxu4Zoc2aKsCR/9pH2d+Vm4Ph9QkSvRzVv76FmFVacg9nMhLjto7RyZ68H7TkS2wwDvjAkEMV3kJYePtiTjn4pAntXuOgDABaSZhWIm1scbKBiSq7ELTsJ0eb7plIej/50b6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxW+6ONT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DA3C116C6;
	Mon,  1 Dec 2025 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764611323;
	bh=hWOrPGrXp0FSreB+cLgKfrOmVZjwbI7HL6KWRWP8naI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxW+6ONTFdkKnH8qRt+V/a6Lqis5xf83eDQ/0gsSHu8BCvTuuW5ml9eAr9YdPcNO/
	 9HEriRPkCoNBOIWasS33PicthSiEVGxZhmUdEb4VTMSMF+lx5Iw8VbGaVNRpLGckuK
	 CvXF5irlHnvVUwfil/E/3uzW8Wgxv8l1g8CoNKPhxmoqK2g/FnJgN2a27mDUrQe2dI
	 fz4vsmGb7MJQ1WMXo4cpnehoCvj/FgOd14h0QR9fkXsQOaAF9uuo7IkTMRBDqtCELH
	 UAzCLs8HyXNhBAN+JiRhQ9W1cWORT5cpi/VmzpzxdOnXdnIZ3FcSC9afOMsE4WzUVt
	 nY/nKaioEssng==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BAA69F4007B;
	Mon,  1 Dec 2025 12:48:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 01 Dec 2025 12:48:41 -0500
X-ME-Sender: <xms:-dQtaU4oaaqORes3Wm3ewfhpLTMHvtSCYqOzgYHmuWJH7gFIV7ig5g>
    <xme:-dQtaTbtswQ-VCP_VypdQYNj5_QuX8_NEUqTZj3ecGemvwfFwcwSY2JzySE537BEV
    LoI9D7uS2gaIigltPdpa2ZWHyfdngib9UZtBvzWvLQt6AEQR5V4Wao>
X-ME-Received: <xmr:-dQtafiZ9zMvQUsY5sugRHb2gKkM_dHTrM5Tj5eU3JHOvhZ7E5AK5FZEL8GJlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehprhhsrghmphgrthesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdhmmh
    eskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtohgtoheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgvfhhisehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhgohes
    rhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggv
X-ME-Proxy: <xmx:-dQtaWZG0jMyLySHMMbquwP107dJMVh7GL-0giiYvJyFgdQO9A0VPQ>
    <xmx:-dQtaaoeqfFdK-zdshvCMSurc5WwgT-gmr58MMcHfABFpSMfNd3LKA>
    <xmx:-dQtaWSF5tQKpTbvq9yQF1JRwV2nJC88cOEb76sUIlXqu2_rPmPnNQ>
    <xmx:-dQtaWk1Z0EjDWP5Qnk1z4D6uf6BceDXkTfsAebjxNg6sw5ixnpxvg>
    <xmx:-dQtaSHg4a8nzvU5LDRMxwuicq463OnYfEB8iIshMyfNSvJIAMmxOruh>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 12:48:41 -0500 (EST)
Date: Mon, 1 Dec 2025 17:48:39 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-mm@kvack.org, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, ardb@kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de, thomas.lendacky@amd.com, 
	michael.roth@amd.com
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
Message-ID: <maleev6ofzlnhi3rmqjawlllxkda4mrgwmb6msz5gz77klfrxl@adpqtakqrxrj>
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <14df1d99-7df0-4982-8029-e66dfb140399@amd.com>
 <dy65eupwalp5wsljetlto27l6tjjvoygeotjd3n7mk7zjc4dma@jf4hzsy6rtcd>
 <f60d968e-6be3-4bad-8bf4-8500ad039817@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60d968e-6be3-4bad-8bf4-8500ad039817@amd.com>

On Mon, Dec 01, 2025 at 11:15:13AM -0600, Pratik R. Sampat wrote:
> 
> 
> On 11/27/25 11:40 AM, Kiryl Shutsemau wrote:
> > On Wed, Nov 26, 2025 at 04:27:29PM -0600, Pratik R. Sampat wrote:
> >>
> >>
> >> On 11/26/25 5:12 AM, Kiryl Shutsemau wrote:
> >>> On Tue, Nov 25, 2025 at 11:57:51AM -0600, Pratik R. Sampat wrote:
> >>>> The unaccepted memory structure currently only supports accepting memory
> >>>> present at boot time. The unaccepted table uses a fixed-size bitmap
> >>>> reserved in memblock based on the initial memory layout, preventing
> >>>> dynamic addition of memory ranges after boot. This causes guest
> >>>> termination when memory is hot-added in a secure virtual machine due to
> >>>> accessing pages that have not transitioned to private before use.
> >>>
> >>> How does the hot-pluggable memory look in EFI memory map? I thought
> >>> hot-pluggable ranges suppose to be declared thare. The cleanest solution
> >>> would be to have hot-pluggable and unaccepted indicated in EFI memory,
> >>> so we can size bitmap accordingly upfront.
> >>>
> >>
> >> I'm not quite sure if I fully understand. Do you mean to refer to the
> >> EFI_MEMORY_HOT_PLUGGABLE attribute that is used for cold plugged boot
> >> memory? If so, wouldn't it still be desirable to increase the size of
> >> the bitmap to what was marked as hotpluggable initially?
> > 
> > I just don't understand how hotpluggable memory presented in EFI memory
> > map in presence of unaccepted memory. If not-yet-plugged memory marked
> > as unaccepted we can preallocate bitmap upfront and make unaccepted
> > memory transparent wrt hotplug.
> 
> If memory that hasn't been plugged yet never gets plugged in or is only
> partially plugged in, wouldn't we be wasting space by preallocating
> the bitmap upfront? Or would that not be a concern in favor of
> transparency?

4k per 64GiB of physical address space should be low enough to ignore, no?

We can look into optimizing it out when it is an actual, not imaginary
problem.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

