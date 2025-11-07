Return-Path: <linux-efi+bounces-5381-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2233EC3F282
	for <lists+linux-efi@lfdr.de>; Fri, 07 Nov 2025 10:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AA534EB066
	for <lists+linux-efi@lfdr.de>; Fri,  7 Nov 2025 09:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC682F6574;
	Fri,  7 Nov 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qEFdDK6z"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B652F5A05;
	Fri,  7 Nov 2025 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507691; cv=none; b=cV/gZljGsm85TGK88SQkWPcYIS8BWHn62TF5Gu42gxghXg9yXDqlLizg5i779KdQEKdjQvYvWsncUhh0K7Uy0GTdTQ7M+WZaF/LGNtv9XdVH91qAFJea+LTNahMENcCwLlVdEeTH2nq4gRBpT9ECeqV9Dl8oKpN+fzTrsusf0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507691; c=relaxed/simple;
	bh=SOUrjOhn2uKWfQ/3III226IBTXZkQ6YU1jH7jBjGG6c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=c+RPPRJUaBKerZ1fQ8nGzrKQGeC01iF4BoMYtehugY9c00koZkzERaMkxwxaAjefdd5QO57IDH1iUgXMwVpfy+0zNEvPUW69ubAngI7F1XFoE5FFZtvoOh9CmHxu4yqmpPtEiBJDV0e8xdN72oVlW7NT9Q+VwcPRthPs0vh0REE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=qEFdDK6z; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5A79RDlh1577553
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Nov 2025 01:27:13 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5A79RDlh1577553
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762507635;
	bh=A/GHzIdqHzaEgpQHWH1jJVSfUcqO6eL8TAku4GgO3gQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=qEFdDK6zKyiC95s+gOLT1gu6Pom3pWMItFd/VKmgBhXKkrM39WF3UwQS0WBzMkksr
	 s6/s6dBIHuufYhYbpHsYkeybUiyQiVNcVOhs6w0BSzQVypPGxZTqctzTn6izQ08MpL
	 EijFEUD5MipD/BIdvYk41rrseSGHuWM81WSL4Nvvj5eAKR54WzDWHJIshf4MsKWcVj
	 9Fzpups0QV8XVFJdjL4UMhbEoh1dH9tEGfX29hdDznsCYco43RXjY5O9ttH9aPbFD5
	 0/qj7oGgNHYxpCLU1lxS2YwRfVZJ+fJ1b9Xh88AFw+CwkcQjn34A6KJOhdfsKuG+nt
	 T1/aa1faRu0ig==
Date: Fri, 07 Nov 2025 01:27:12 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ard Biesheuvel <ardb@kernel.org>, Peter Zijlstra <peterz@infradead.org>
CC: Dave Hansen <dave.hansen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sean Christopherson <seanjc@google.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v11_5/9=5D_x86/efi=3A_Disable_LAS?=
 =?US-ASCII?Q?S_while_mapping_the_EFI_runtime_services?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXFQaGaz37MNKXXjhUKy_mP-5teCDj80-hjUPHw4x+TKrA@mail.gmail.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com> <20251029210310.1155449-6-sohil.mehta@intel.com> <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com> <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com> <6dec8398-3f7c-44db-a30d-33593af0217f@intel.com> <efd6ec82-5576-41f1-a244-2f80d72e93e4@intel.com> <ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com> <20251107090406.GU3245006@noisy.programming.kicks-ass.net> <CAMj1kXFQaGaz37MNKXXjhUKy_mP-5teCDj80-hjUPHw4x+TKrA@mail.gmail.com>
Message-ID: <1962E702-8F75-4137-9000-A607E164914B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 7, 2025 1:22:30 AM PST, Ard Biesheuvel <ardb@kernel=2Eorg> wrot=
e:
>On Fri, 7 Nov 2025 at 10:04, Peter Zijlstra <peterz@infradead=2Eorg> wrot=
e:
>>
>> On Fri, Oct 31, 2025 at 11:12:53AM -0700, Dave Hansen wrote:
>>
>> > But there's a pretty broad set of things that are for "security" that
>> > aren't necessary while you're just running trusted ring0 code:
>> >
>> >  * SMAP/SMEP
>> >  * CR pinning itself
>> >  * MSR_IA32_SPEC_CTRL
>> >  * MSR_IA32_TSX_CTRL
>> >
>> > They just haven't mattered until now because they don't have any
>> > practical effect until you actually have code running on _PAGE_USER
>> > mappings trying to attack the kernel=2E
>>
>> But that's just the thing EFI is *NOT* trusted! We're basically
>> disabling all security features (not listed above are CET and CFI) to
>> run this random garbage we have no control over=2E
>>
>> How about we just flat out refuse EFI runtime services? What are they
>> actually needed for? Why are we bending over backwards and subverting
>> our security for this stuff?
>
>On x86, it is mostly the EFI variable services that user space has
>come to rely on, not only for setting the boot path (which typically
>happens only once at installation time, when the path to GRUB is set
>as the first boot option)=2E Unfortunately, the systemd folks have taken
>a liking to this feature too, and have started storing things in
>there=2E
>
>There is also PRM, which is much worse, as it permits devices in the
>ACPI namespace to call firmware routines that are mapped privileged in
>the OS address space in the same way=2E I objected to this at the time,
>and asked for a facility where we could at least mark such code as
>unprivileged (and run it as such) but this was ignored, as Intel and
>MS had already sealed the deal and put this into production=2E This is
>much worse than typical EFI routines, as the PRM code is ODM/OEM code
>rather than something that comes from the upstream EFI implementation=2E
>It is basically a dumping ground for code that used to run in SMM
>because it was too ugly to run anywhere else=2E </rant>
>
>It would be nice if we could
>
>a) Get rid of SetVirtualAddressMap(), which is another insane hack
>that should never have been supported on 64-bit systems=2E On arm64, we
>no longer call it unless there is a specific need for it (some Ampere
>Altra systems with buggy firmware will crash otherwise)=2E On x86,
>though, it might be tricky because there so much buggy firmware=2E
>Perhaps we should phase it out by checking for the UEFI version, so
>that future systems will avoid it=2E This would mean, however, that EFI
>code remains in the low user address space, which may not be what you
>want (unless we do c) perhaps?)
>
>b) Run EFI runtime calls in a sandbox VM - there was a PoC implemented
>for arm64 a couple of years ago, but it was very intrusive and the ARM
>intern in question went on to do more satisyfing work=2E
>
>c) Unmap the kernel KPTI style while the runtime calls are in
>progress? This should be rather straight-forward, although it might
>not help a lot as the code in question still runs privileged=2E

Firmware update is a big one=2E

