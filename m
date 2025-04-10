Return-Path: <linux-efi+bounces-3272-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E17EA84B0F
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 19:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D06C9C2171
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AFD1EBA16;
	Thu, 10 Apr 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsdimp-com.20230601.gappssmtp.com header.i=@bsdimp-com.20230601.gappssmtp.com header.b="uSpK28LX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E204284B22
	for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306244; cv=none; b=iIxdqZ/Bi9LbLGnp+ssZK8yzWZfVuKHgsbF6Darf5dyP77zWL13tvH2cTYg/bSTgSFFbPK40Z3r9aX6bTwNdphz0ktdzUt4orNMygg/xRYxg7oncHcucZJe3KJdLhBlkG7Estj4Jp/pYgRro9820ew9sUdjrwWIAyrw8ETUSWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306244; c=relaxed/simple;
	bh=4+YG07R8TLt+zEwDga7+bpHbC6ZQDLVGOeV0yqohbzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJwZ3aN0RHuaJoDhKEUpGRWRmb9dnsHLD5DL3aZGkKy0BB8Js3ti9qPIDGi2DcGzS/k2IKkR1tUS2RciuK9GLWmbnkB/fV2oMDl1levAAsA0Pq5QcfTnmdeGKhRVBzVHRaWEEUqBJAe2WQvJKnGqAt22DV7/TDAT2F4e8lDmrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdimp.com; spf=none smtp.mailfrom=bsdimp.com; dkim=pass (2048-bit key) header.d=bsdimp-com.20230601.gappssmtp.com header.i=@bsdimp-com.20230601.gappssmtp.com header.b=uSpK28LX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bsdimp.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bsdimp.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso579546a91.3
        for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1744306242; x=1744911042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REpeZ1Sw28ZvGsXyZg2yIEevnwLOj4CN+gj0ClU3XFs=;
        b=uSpK28LX+iKj5WhyS2kL2eHQwH4eFOGIQNHmSz8sLUvXYgEHT+6NBFj7ETsO5t0sdD
         m52nrsseGN6y+3k4b+tDJZwWPyYZdipNqth10bFWX5TqnLFd8FajwbP3Z5odpDhmtDsf
         +w2z70y87/V1wKxZFv6P+DuYDCdmLkcdhq7KFd+xs0lYcoopu5yL0lq5QuJJdXOGR48S
         DTMV8rc8YyImIRthwSqohY+ZUarFy4yUJQ3zyzckyXVLqAWK2vk0FuG06dDjde4JSTWp
         20xMEQ/1kU9Vi4VxPiKRb2MantLTTNxbuS3BWvz+RrpuCY7ZZvD//cKRF2YHayyDyIDl
         CKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306242; x=1744911042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REpeZ1Sw28ZvGsXyZg2yIEevnwLOj4CN+gj0ClU3XFs=;
        b=PI82HS3lWZJJo0r7M+hPxH/uOaItL77nWxzhDPVNbYv79NTSLR4xdWdDPbLf3BwRLO
         fQIa66F3QTljrNX3HdbFcN9lYqIW8r20RoRmLnWYwf3j16Op7tznaOQhaOlIr+PWAI6p
         S9EGvzGbzZpXffi78f2kq/p1WjxXM5GZJ+CsmsB/X7YGgQSll2MQ9LiaFhpPDVLhqI6B
         ydLhEoOE/Zfp//F20mkytodAmGyHoct05lK5htiIWx4sOLnbWK+ZyuuciM8r/6HveEoY
         etjPRzuoc+tYZDihUniD21X8tpVRI0vG25U02D86IjkXZ4Eh8XbYx1JYXfjXgPJoksaJ
         t3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVX2u/TFMBOr+HBwCtDpe3qs5iFUUdKtqz75lIl/iz5J0EkHPKLF22fzuMJecl1GFzNTI1Ng7SRsiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw5xatmBU604fpADqQTCAC4OlRcN5FEvmaXFCrXWdKDBTnmype
	Z3Y3W+LNAshR6qR7D1IrOZJrPfMNLmFLCjr870V9p0VSnystKf1aYCMPH5DagjWvG/C3jN/ElmT
	3SmDuJBzE2zTI0/svyRMO+DsQ1j4Ubpq7/TpyyQBIgGcURYpKYfY=
X-Gm-Gg: ASbGncts8LzvNsxygmidmRFgi89bPooiVUze6hz5LLsGqN+5ecta4NzxIy/FRqUUaQX
	XX2FkhLWffxy+WYKrHFK/RgnM3ABCYwovA+TM3f+L+C7OzUX6InP7gIC7iX9dVcRYCLBbNJIfQG
	8Pa1z2JP4+86xA88nXvM0/sw==
X-Google-Smtp-Source: AGHT+IFkCqFfDWMReZfDZ7HtQQe7/vcNcLSYMdmHOyDJOlZoOdN02as75wRhCYBWoQ14ZLiQqoOYXKUBLeN94tnDq5Y=
X-Received: by 2002:a17:90b:280e:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-3072ba1f94amr6300579a91.33.1744306241613; Thu, 10 Apr 2025
 10:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANCZdfpOs6cTSacxzF013AUwOW78oUf5kY11nbTYMrT7W2oP2g@mail.gmail.com>
 <CAMj1kXGcJuf+s5JcKf-a25jwNeWGn+sHhkai+HRYHTnA2z3D2A@mail.gmail.com>
In-Reply-To: <CAMj1kXGcJuf+s5JcKf-a25jwNeWGn+sHhkai+HRYHTnA2z3D2A@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 10 Apr 2025 11:30:29 -0600
X-Gm-Features: ATxdqUEbMvAnVq298Hg2vmm5qcS0vKgkJq6JKnyxqEgA65iCuflCmZA-ODkWJaU
Message-ID: <CANCZdfrt74KF5=JWsm3XtYE9wc=AvZbs6A_n1C+YE3KOFQKaKw@mail.gmail.com>
Subject: Re: Why isn't the EFI memory map published in /sys/firmware/efi?
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard! Thanks for your help so far! I have some followup questions.

On Thu, Apr 10, 2025 at 1:12=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> Hello Warner,
>
> On Wed, 9 Apr 2025 at 19:29, Warner Losh <imp@bsdimp.com> wrote:
> >
> ...
> >
> > The first one is the EFI system table. On aarch64 I can get it from the=
 DTB
> > in /sys/firmware/fdt, but it's unpublished that I can find on x86_64. I=
 get it
> > from boot_params that I read from the kernel with /proc/kcore there. Is=
 there
> > some reason this isn't published in /sys/firmware/efi/systab or similar=
? A
> > number of other, auxiliary tables are published, but not this one that
> > I could see.
> >
>
> In general, if something does not exist today, it is because nobody
> needed it and so nobody bothered adding it.
>
> If you need this, please propose a patch and we can discuss on the mailin=
g list.

OK. I'll code up what I have in mind. Part of it sounds
non-controversial, other parts
may be less so...

> > The second one is the memory map for EFI. A subset of it is exported
> > /sys/firmware/efi/runtime-map, but it is only the runtime services mapp=
ings,
> > not the entire table. FreeBSD populates its memory maps from the EFI Me=
mory
> > Map that's obtained just before exit boot services is called. So my nex=
t
> > question is why the full map isn't also published?
>
> The full map is not published because it is a snapshot of how memory
> was being used at boot time. So at kexec time, it is generally out of
> data and so the kernel needs to provide an up-to-date memory map
> anyway.

OK. That's the first bit of confusion for me. I think I'll ask a
clarifying question,
though. While the memory map is fixed as far as the EFI firmware is concern=
ed,
the Linux kernel has actually started using parts of the EFI memory map tha=
t
it's allowed to use (so those should be reported as a different type), corr=
ect?
There's no code to actually do this at the moment that I can see, is
that right too?
Plus some firmware lies / violates the standard by expecting BS_CODE and
BS_DATA regions to stick around as data drivers need later sometimes really
are there. Linux copes with this unfortunate situation by rewriting the map=
 to
say that it's really runtime data (though maybe still with the same type if
I'm understanding the code I'm looking at).

So, while it doesn't change often, it differs from what the efi stub
got, potentially,
from the EFI firmware. So there should be an interface to get the revised m=
ap
and that interface doesn't exist. And it's somewhat unsafe or at least
fragile to
use the echos of the original data I've found.

> because they shouldn't change. However, the x86 kernel does some
> disgusting things with the memory map and uses the EFI_MEMORY_RUNTIME
> flag for its own purposes.

So I found the EFI_MEMORY_RUNTIME stuff. Are there other things I can look =
for
to understand entirely? Or can I assume, at least for x86, that the
data in the 'efi'
data structure is what should be used, regardless of how we got to that poi=
nt?

But that's how the runtime map can change after ExitBootServices and
SetVirtualAddresses is called. It doesn't really change, but Linux'
notion changes
and sections that once had EFI Firmware data now has Linux kernel data so i=
t
would be inappropriate to tag it as its former EFI type. Is that right?

All that code is x86 specific, though. aarch64 (and other
architectures) will need
other attention.

> Note: the runtime-map is only published by x86.

Yea. I had noticed that. Now I understand the backstory for that.

> So TL;DR - the original memory map is of limited use, and on x86, not
> even the runtime regions can be trusted.

The original map is working. I understand, though, that "working" should
really be in quotes.

> ? Most of the same data is
> > available from /proc/iomem, so there's not a data visibility issue that=
 I can
> > see. BTW, /proc/iomem isn't suitable because it's a processed version o=
f the
> > efi memory map that loses information. I can use it for the loader to f=
ind a
> > spot to put the kernel, but can't use it as the memory map for the Free=
BSD
> > kernel reliably. The FreeBSD EFI boot loader puts this data into a meta=
data
> > region that's passed to the FreeBSD kernel for it to consume, and I nee=
d
> > to retain that functionality.
> >
>
> Sifting through the contents of RAM is not the solution here.

Honestly, I'd prefer not to do that, as well. But I wanted to get a
"working" solution
so I knew the complete list of data that I needed before starting this
conversation.
For the most part, I have enough control over the boot environment that I c=
an
switch to it quickly once it's been accepted upstream.

> > So, since I can't get the EFI memmap data directly, I have to use indir=
ect
> > means. For aarch64, I can find the PAs and metadata for the memory map
> > form FDT.
>
> This is an internal ABI that may be removed at any point.

Hmmm, these are documented in arch/arm/uefi.rst currently w/o any such warn=
ings:

"The stub populates the FDT /chosen node with (and the kernel scans
for) the following parameters:"

And it's those parameters that I'm parsing.  But I guess it isn't in ABI
tree, so maybe we're noting the same things.

> > Ditto the EFI system table.
>
> Same

OK.

> > I pass my trampoline code the PA and
> > length for the memory map and the metadata area so it can copy the
> > needed data for the new kernel.
> >
> > For x86_64, I open /proc/kcore and read out the boot_params structure.
> > I can get the PAs and metadata from it. I do a similar trick in the tra=
mpoline
> > to copy the data. This works, but feels very 90s BSD netstat to me (whe=
re
> > all network stats were read directly from kernel variables and had issu=
es
> > too long to get into here). This is less than idea as well because I ha=
ve to
> > rely on the Linux Boot Param structure and it only exists on x86.
> >
> > On permissively configured systems, I could use /dev/mem or /dev/kmem
> > to read the actual map so I wouldn't have to do it in the trampoline an=
d
> > could use the EFI memory map to find where to store the kernel rather
> > than the /proc/iomem map that I use (it's a subset of the EFI memory ma=
p
> > data, but not enough of one to reconstruct it). But those options aren'=
t
> > available for some of the environments I have to boot in.
> >
>
> None of these are acceptable solutions.

I totally agree. I found the data I needed, but definitely wanted a
better way to get
at the data.

> > FYI, the Linux kernel gets around this, at least on x86, by cheating a =
little.
> > It uses the bzImage kexec handler to copy data from the current boot_pa=
rams
> > into the new kernel's boot_params and passes that to the new kernel. It
> > does this because, I think (I've not traced this out 100%, so be kind o=
n any
> > corrections), kexec_file is the typical path and the kexec handler can =
find
> > the bzImage header in the file. My trampoline doesn't have that header,=
 and
> > attempts to add it have been unsuccessful, so the path to the new kerne=
l
> > goes through relocate_kernel in arch/x86/kernel/relocate_kernel_64.S wh=
ich
> > clears all the registers and doesn't pass in the boot_params (which is =
why
> > I read it from /proc/kcore).
> >
>
> In true x86 fashion, the kexec code is a jumble of many different boot
> paths, and you shouldn't expect that anything remotely as messy will
> ever be supported on other architectures.

I did aarch64 before I did amd64 because of the mess (both in Linux and in
FreeBSD since it is an older arch with a lot of baggage).

> > So why isn't there a /sys/firmware/efi/map that I can just read?
>
> Because nobody bothered to add it.

OK. I like that answer. I can add that and migrate my code to using those
interfaces and post the code here for review.

> > Why isn't
> > there a /sys/firmware/efi/systab that I can get the system table addres=
s
> > from?
>
> Same
>
> > Code for these wouldn't be hard and I could submit that code to
> > make publishing the data more controlled and regulated. However, I
> > thought it would be prudent to discuss the reason for the omissions
> > first to see what the thinking there is.
> >
> > Thanks for your time and for whatever help and insight you can give me =
here.
> >
>
> For the record, it would be much better to not rely as heavily on
> kexec internals as you seem to be doing, and instead, implement a
> minimal EFI boot services layer for kexec that should be able to boot
> any EFI compatible operating system. The boot services part could run
> while the kernel is still up, and only the pivot into the new
> environment (after ExitBootServices()) would execute 'in the dark'.

Hmmm, that's where I started this journey 3 or 4 years ago.  It don't have =
all
the pointers to videos I had then, but the first thing I tried was to
get FreeBSD's
loader.efi to run on a modified kernel that added an exec type for PE files
and did all the EFI emulation. That failed because ExitBootServices had alr=
eady
been called. While most of the data can be harvested / faked after the fact=
,
SetVirtualAddresses had also been called. FreeBSD assumed VA =3D=3D PA for
that table and Linux doesn't, so there was no way to emulate it. So
right off the
bat some changes would be needed for this environment. I also ran unto issu=
es
where loader.efi created its own %cr3 mapping table and then we jumped to
the kernel and that interfered with any interrupts that would come in (I th=
ink,
it's been several years since I tried this path). I used the tree at
git@github.com:oweisse/linux.git for these tests. When I looked at it, I ha=
d
several other reasons for thinking this wouldn't work out, but I
didn't note them
down. One of them was at the time I had to run in an environment where such=
 a
large kernel patch wouldn't even be considered (plus the tree was such that
I'd have to bring the changes forward to a newer tree and they were clearly=
 done
as a proof of concept not as something carefully thought out to upstream).

The coreboot folks tried booting Windows, and their experience is here:
https://trmm.net/chainload/ but the tl;dr is basically that there were too =
many
devices that Windows wanted to talk to during boot for emulation and they w=
ent
the route of not calling exit boot services... Even then, their
results were a bit
fragile.

So I'm not saying no, but there's been a lot of effort put towards this by
others to get to an unsatisfying outcome and I'm not optimistic this approa=
ch
would work out.

> I have been meaning to spend time on this myself, but I haven't gotten
> around to it. I did implement minimal the EFI boot services layer but
> no time to plug it into kexec.

Once you have something I'd love to try it out. I don't want to don't want =
my
skepticism to get in the way, but it sounds like a solution is some time in=
 the
future and I need a solution in the coming months.

Currently, the only thing that I use undocumented or semi-documented interf=
aces
for is to get the memory map and system table. Once I have that data, I jus=
t use
the documented kexec_load interface that puts code in memory that I jump to=
 with
all the state that is needed already in the metadata structures that goes a=
long
with the kernel and loadable drivers. Well, on the arm64 side of
things, I do use the
system table to lookup the memory reserve table to learn of the
gicv3's memory tables
so we don't allocate that memory for the OS before the gic driver starts.

Warner

