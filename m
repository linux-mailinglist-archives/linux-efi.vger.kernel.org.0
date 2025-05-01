Return-Path: <linux-efi+bounces-3524-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FF2AA62DF
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 20:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F617F795
	for <lists+linux-efi@lfdr.de>; Thu,  1 May 2025 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3001620C014;
	Thu,  1 May 2025 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXdnZW4m"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D5821B9F2
	for <linux-efi@vger.kernel.org>; Thu,  1 May 2025 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746124455; cv=none; b=OeqAp2GXtBMF9zLQCT2vRdIp5VifHVtpNqUCLV+6NvbIlj0+ygCeJ7RM4dM272TCpsmhi/2Pd6fEqdxdfCLxSzPX7g0vaCqzLnxdP5kYPXc1cRV//J5PuWqwmdruZW0pSHTZd+trkqh8TT4wFnqGjXYIu+wQA0zVA0zpfpJvDgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746124455; c=relaxed/simple;
	bh=+DAZETPgGKlVNaxrjII/8WTA3PntLOU1NMdtZAGUhfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uH5AueksKp4/XdSOzOZzQMwXFfkbmtfqfr9c/tihcoSxBCqfkUY921FuPw4BngYNUicovBzWn9j1mfAsOH3ttbQ6oaMKClztW2T6F54frhf4YPR1A/JHK6eaGVX1itmd2DQxSLlXCZmq6U9XoN3+lLVIJoCotbEJPNYXB1CXji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXdnZW4m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746124452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qKIEW/lhMjwEMGxy/raOMlbK5hykaujRDE/weD2Tms=;
	b=iXdnZW4mBrZFGLhYk8ycuy2vJIHdStU9WpgSbmHPpwUu8ucVBaevB6QLslhSmP6XKBz+fm
	eLkcaQz+zpic8igDhys2vre0Dfy53HGTKEzxGrz8RS/6wbrchRob1xJrO4DXqFfmIJnl6y
	jv+vPlbtS2aI4A9Miie3p3TjcvXdmnY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-6dlyXaVXPjOVxtPcFiR-kQ-1; Thu, 01 May 2025 14:34:10 -0400
X-MC-Unique: 6dlyXaVXPjOVxtPcFiR-kQ-1
X-Mimecast-MFC-AGG-ID: 6dlyXaVXPjOVxtPcFiR-kQ_1746124449
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso438220f8f.2
        for <linux-efi@vger.kernel.org>; Thu, 01 May 2025 11:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746124449; x=1746729249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qKIEW/lhMjwEMGxy/raOMlbK5hykaujRDE/weD2Tms=;
        b=U6WzQathFrArxAP9ZjuUF40TcmWtGpZxwq6pIZiW/APK/IuhFWUOt3d5kiQ1QlfuKL
         lXqKrH2Ks7RV2p7MgiInCEk0YSjJQbZHjIx3tI+zuNJVXKva+pNd0GWzkmyQGNNdnxQ8
         Ljskn4IOPZDe+BdOBHF/KAxnyQJW8OpPzYE6kCgRjBZkYF3GUXNciiW8SDDEATyeUhR+
         FX9t3zcHZfSTrUzeKdQJsFPq/EnaOB2mz992NrvaE38sUNaz0gabIKHQqUG8yhaeIH64
         K6Nyoayh2cUzTD+nhh9QyLoZNyWDVtwnK3Zzyw6l0cUFDWseXgH9r93qEw+kV2zahZPA
         puTg==
X-Forwarded-Encrypted: i=1; AJvYcCXk97Zuj4emsKJzNZbi4vcFRbkY/7X9gn9nKOTNLUYqXxBMWLVVDrnZMR/X0oenQNSnXJdZTo32ocw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYuw1+0piN+9Y6CdILaIqw4nMTJMMhwD1je9yYeERcrDoka9Yt
	VM3MqSic2chGZqnLj2MJ6LqUHG7feI5rP2TIiSP39OZrvTO2XnZUoUB8MKzRehIAFU4QQeKDq0s
	oZZUEAiRmi79My4r3xkpjDwgRRj6jq5dneDHNA7ods815Q7cuj9hJpQnj0XicpuHg4rptwsnzug
	TRaCyS4DkrKsOCyBldYrsk8lu7VViPgySq
X-Gm-Gg: ASbGncutgqxf2799mFtv6vmrowgnvMA0yr+L5ArZmlc3Crcx2CG1qvMxYVl/NsUaCck
	a1GajGYXyIVIBqk75mg7I5cOO/pFJYaEJy+TdKV423nrrGSDDlaHQ3QXwzA6+sibj9VlV
X-Received: by 2002:a05:6000:2cb:b0:38f:28dc:ec23 with SMTP id ffacd0b85a97d-3a08f761e95mr6926081f8f.19.1746124449418;
        Thu, 01 May 2025 11:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8pyZZxNLsDKgK+s6EiT/5Z0RvhAJbHB3j6sE0QEEuK4GrGOmkb5NB8jNyV3jUBy2M6Ty7WMK3PucatHbyoBs=
X-Received: by 2002:a05:6000:2cb:b0:38f:28dc:ec23 with SMTP id
 ffacd0b85a97d-3a08f761e95mr6926061f8f.19.1746124449084; Thu, 01 May 2025
 11:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430110734.392235199@infradead.org>
In-Reply-To: <20250430110734.392235199@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 1 May 2025 20:33:57 +0200
X-Gm-Features: ATxdqUGj_DEOILwA7gJmdwUbmKq2o1Nt9LtM9RStnzYMraMRgnH01086KHJWMt8
Message-ID: <CABgObfZQ2n6PB0i4Uc6k4Rm9bVESt0aafOcdLzW4hwX3sN-ExA@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] objtool: Detect and warn about indirect calls in
 __nocfi functions
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, seanjc@google.com, 
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org, jpoimboe@kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	samitolvanen@google.com, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 1:26=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> Notably the KVM fastop emulation stuff -- which I've completely rewritten=
 for
> this version -- the generated code doesn't look horrific, but is slightly=
 more
> verbose. I'm running on the assumption that instruction emulation is not =
super
> performance critical these days of zero VM-exit VMs etc.

It's definitely going to be slower, but I guess it's okay these days.
It's really only somewhat hot with really old processors
(pre-Westmere) and only when running big real mode code.

Paolo

> KVM has another; the VMX interrupt injection stuff calls the IDT handler
> directly.  Is there an alternative? Can we keep a table of Linux function=
s
> slighly higher up the call stack (asm_\cfunc ?) and add CFI to those?
>
> HyperV hypercall page stuff, which I've previously suggested use direct c=
alls,
> and which I've now converted (after getting properly annoyed with that co=
de).
>
> Also available at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/core
>
> Changes since v1:
>
>  - complete rewrite of the fastop stuff
>  - HyperV tweaks (Michael)
>  - objtool changes (Josh)
>
>
> [1] https://lkml.kernel.org/r/20250410154556.GB9003@noisy.programming.kic=
ks-ass.net
> [2] https://lkml.kernel.org/r/20250410194334.GA3248459@google.com
>


