Return-Path: <linux-efi+bounces-591-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E3F85B1D7
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 05:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8B22822AF
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 04:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD655381E;
	Tue, 20 Feb 2024 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBZYbQva"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63024535D0;
	Tue, 20 Feb 2024 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708402204; cv=none; b=pYGwrV7tdbTWNUCJAJhR0mnteWAVCJwZCdrXIZcD8lXopEmwhu+PTwfVzDdcvo2YJYx39eQ5irslLqewR9NjSldbj7H85qReWotzNXcQpSTcBCSpZwuyS7RIsBV/7OeySDJJ0Li1YpNmeJWcK60Kgrhr7puAdb0RggIBL+rHEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708402204; c=relaxed/simple;
	bh=woxjKC7WFFEoqeaxhQsKmXCBIwq3jzFBV0fzqaCLZYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B80OVMIXbtFRpNKaYvxgmoFISaEjPkhrBzVo6a9E2hvtVNId4xS2Rqi3vkDPnrLTLa5Ts/rPvtv7LmWJDZyeVRm+gmjIDHIzSnfR2oHjim/z9omqI53XkFqWlBC/84m+NTRICtL9lQwqcWe247/+Cb6S8XqkI1iFnIzCkOwSRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBZYbQva; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78726494b46so310225885a.1;
        Mon, 19 Feb 2024 20:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708402202; x=1709007002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kHuAqO5ZD/hbBfrYMNHXsD8jQOPncxvEGQ69fY7+c8=;
        b=TBZYbQva6dItkpiAD1+wGs52fR0yBHdd5KxgNAsmBLu4fp2LhxkCT1O1n2Uk/nI99K
         jkGK0Q2n9VTH7/wE8EAHv7CHkgnbfq7uQmssfYr5S4Zo72EGABwmP22bFY4zRCnJJYn4
         qgJLJSdYVYNSsfvAFDy1d6ilpdyOULDSUghG6yAGSFrShm4/85SxEuG+5Wat+82zvR16
         fR2jLThsa2XuQwZTTSUZ1YzTY6aHtC/wspRiGGpdRGLyBX56EbL67QxANU3wbiGxcvE/
         eD05wIkbF3LDt5/RYtu49/veLsxK4LHHSOrn5hYQe/9DftAkCW5VkBp1WNKTotEmytQj
         0XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708402202; x=1709007002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kHuAqO5ZD/hbBfrYMNHXsD8jQOPncxvEGQ69fY7+c8=;
        b=O0OPVOr6Zbc/zSlR4bv4p7rgGfzUY99ldG/irLDxzXYdgT+FPgspNMaNyRDf5f03EJ
         XpmVJ+XvLRA/AOpqv9drP1Q3CltrK7QYwRueM1z/viPYxEW+8z7xIt7TGqfUbkOUda45
         jp1gjlpovbB/F0JNvuB0DclleTPDLVF791Wihp+fdyd3Yt8suWx1TfJx67oG90O87wLs
         OtP8Qy9TKAPBHo8r4D/ki+UM4BgUl7RHVUFOyogfhuE2WWFEC3EVEmmYsFSRIw3bhhLc
         EV8+sWIzE640/7vRxhNwXFIUtHmrQzC418a4x7N4BJ3ncke7Q+NOEMPhZ27F2pb3MaTZ
         3BsA==
X-Forwarded-Encrypted: i=1; AJvYcCWXJtlhHJ2PssMAkX7qa3F5c7PGgp1PqRzwzACYIouJihRt4HUThUbastDNItQTyNt6/Ge178BDP1/l9oPpf0eEi4OkEADW2nTO5M+ZCHCMNMb4yBVEPyFXF6s6t0UeaV4duX1xnbSOkhCKo2FG4pzW620KQ3OBju3YUy2Io5ZG
X-Gm-Message-State: AOJu0YxRDymx/3xTAmhFKUBn0RcxGt+MwVEsBDRT0u7I1kxVHAxuQ+8o
	qokmv645y2PbPe9/WwMrdPdXrGF7wh+mCtv3N8DJusH+gMfJGojL
X-Google-Smtp-Source: AGHT+IERdjvmhxqnhucMie6TcjrVdkmnqQIy27KFcGREGVCQ4OzGqN6ssTZl9j+rNHEZmsGfz1treA==
X-Received: by 2002:a05:620a:219d:b0:787:5c2d:2b88 with SMTP id g29-20020a05620a219d00b007875c2d2b88mr7047376qka.59.1708402202133;
        Mon, 19 Feb 2024 20:10:02 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id y11-20020a05620a0e0b00b00785d538aebdsm3043906qkm.95.2024.02.19.20.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 20:10:01 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 356B327C005B;
	Mon, 19 Feb 2024 23:10:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 19 Feb 2024 23:10:01 -0500
X-ME-Sender: <xms:GCbUZdv9w8YYxuqFlNjzaCXABcgUSNxtBtyot25QKNl3ZzdIKjlHXQ>
    <xme:GCbUZWf0X--Wr04TafEfPCjR9UYeOxsgxKrFAVwx9x76i0pmZOhEQyPE2L1UuGc67
    NawBl1yQwhU0GZlCw>
X-ME-Received: <xmr:GCbUZQzyw7k1d8SDJykTqnB-R0cBXUX1EQ3-N9o0lIPLndSGLsU-sxkZlRd0GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:GSbUZUND2PO12M7hLsbU3pw_bniUk5wsm8Scnaj4EwireH4i1GnkNQ>
    <xmx:GSbUZd-ZincE3FfTIyT0q72gjCyCqFK7xywKbxrHlRHEyXKL58LBlA>
    <xmx:GSbUZUV6vChuXxaiTOpGLDdj9Ir6KkyZA8ScOckvM4YffRb3fH96Yg>
    <xmx:GSbUZWNmW9iHCqr0cs9juiXhhF_F7K3vk3Lr8_1QFlzD6pdI3JWwUQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 23:10:00 -0500 (EST)
Date: Mon, 19 Feb 2024 20:09:44 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oliver Smith-Denny <osde@linux.microsoft.com>
Subject: Re: [RFC] efi: Add ACPI_MEMORY_NVS into the linear map
Message-ID: <ZdQmCEepdOE2R7gS@boqun-archlinux>
References: <20240215225116.3435953-1-boqun.feng@gmail.com>
 <2024021718-dwindling-oval-8183@gregkh>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021718-dwindling-oval-8183@gregkh>

On Sat, Feb 17, 2024 at 08:49:32AM +0100, Greg KH wrote:
> On Thu, Feb 15, 2024 at 02:51:06PM -0800, Boqun Feng wrote:
> > Currently ACPI_MEMORY_NVS is omitted from the linear map, which causes
> > a trouble with the following firmware memory region setup:
> > 
> > 	[..] efi:   0x0000dfd62000-0x0000dfd83fff [ACPI Reclaim|...]
> > 	[..] efi:   0x0000dfd84000-0x0000dfd87fff [ACPI Mem NVS|...]
> > 
> > , on ARM64 with 64k page size, the whole 0x0000dfd80000-0x0000dfd8ffff
> > range will be omitted from the the linear map due to 64k round-up. And
> > a page fault happens when trying to access the ACPI_RECLAIM_MEMORY:
> > 
> > 	[...] Unable to handle kernel paging request at virtual address ffff0000dfd80000
> > 
> > To fix this, add ACPI_MEMORY_NVS into the linear map.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Cc: stable@vger.kernel.org # 5.15+
> 
> What commit id does this fix?  Can you include that as well?
> 

It should be 7aff79e297ee ("Drivers: hv: Enable Hyper-V code to be built
on ARM64"), but as Ard mentioned earlier, this could be fixed at the VM
firmware, and Oliver is working on that. Should the situation change, I
will send a V2 with more information and include the commit id.

Regards,
Boqun

> thanks,
> 
> greg k-h

