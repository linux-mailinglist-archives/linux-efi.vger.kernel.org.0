Return-Path: <linux-efi+bounces-2604-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC43BA09A0C
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 19:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F93169122
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 18:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871F628EC9F;
	Fri, 10 Jan 2025 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z+Qzw6SL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1AE28DB1E
	for <linux-efi@vger.kernel.org>; Fri, 10 Jan 2025 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534880; cv=none; b=uXpHZCBWy8K7RCNrFrHVBry6NM0qolaaTnKOr0AoUFA+liFGPB1J+tjdQRADHF0cmOK6WRv3OvIcF0SNwHX/L79yklZkA3ytyDi+Vylvhc6pNeV1j7RnGtYLY3jVkjZ48So6FA3oiBMfklg+S5XY+F2K2WGorwcbEDOatZZvOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534880; c=relaxed/simple;
	bh=qC2aC8eAp33KA8O+Z6LlsHyIL/uhbg4PRbpKGbN5hWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jeCMtlruOclVPohEQA70Ay55C8UBykVOBEVCa8wW3SWHmZ9SCPhZOP+IzNZRCtSCXNGoSS51KRNu1S3yGY4H+QDwnthXXBehHDsmolIyo82WDP+rNsTzMnjsT0nvCYpSSrE/6KTPUPJC4zsedBuaxWFtYBeqRdbZiV6wdGXWZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z+Qzw6SL; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-3023de5b71bso14073091fa.0
        for <linux-efi@vger.kernel.org>; Fri, 10 Jan 2025 10:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534877; x=1737139677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFKS9He99X0lK3xnnbI99ZyULyVP6qmX2/a79HHV3Mw=;
        b=z+Qzw6SLSzzOhtQmg+Vrms/uMhgSKUbqBb7I0ogFQyBKmTrFWr81HXf1zRKD8Qkytg
         pbI9PzQ16YLXo5NS7gaZhkPFX47MccU+iLxL73OMhKQkUMYdZNf+BpUSuwEdyMcP0Ted
         whq+o6RWM3OgxNVhEraIwDJHTAFDMHkxJ0GVPGnZmnxtmC4Brj1M7Hu7b7iXR0GVy0Ox
         wxSyuF1ipDpp+zGwv+0Ig4+LV/PHDBp9iuXeEvl/zcxsVzg5xw6iCiF5p7Qmpwwdbfkm
         zmIpwAHKhwTkKc6QVVd4PPcLaRA4dWsHYScP5wtoehjQaffgnK/gNTwEncf8zJyLqgiL
         yrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534877; x=1737139677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFKS9He99X0lK3xnnbI99ZyULyVP6qmX2/a79HHV3Mw=;
        b=VAgzqQ2kQ6SFpp8HNcr2/rB9AoIYkGX5OCgfoO/qXYwlz3LYwBQ1CQX5mOdHPJrbnC
         gTDWqdveviSP9C3mCC9B4TUTIFdcXBTs4LCCB1VbWeZ+Lz+ZLlKOR6Ke8/bklrK15yl+
         PoRsMECXHf/uHuwKV7qqNYEbPcHJytCA5eBLP9DTCw2l51Iq7lZUgIfq9FLarCRZa1O1
         6az8eXLwrEKXvaq/oGHS5uVnI6oBbZPPI+gdMq1Gu0JU+cB6+hg7G0CBwzliQX/MM0gn
         WmKQwaKNH5//2IDcEnCRrixOyGkuCeFiysZ6c5iqGDwWgz870dT+XJVGn/ISB2zH4/p+
         cPKg==
X-Forwarded-Encrypted: i=1; AJvYcCUUfyU6aLQIjNO8NKHK7ZgKLRe0hz52HAAerHsxosEJW4gqq6haOIShZ1y/+kRpgU5MpKnfExoDN3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyamnQVP034w1yokEd/UAfuKJaRYssJ3Iz1hGqGaBBG08JLVUvu
	DD+jNV4C0L3tmRlQIsQPd1pvA2QOopPOESomq0p3KueHolOo6aeozSpoEsq1klZoR3QEoL3UQ4P
	3hl2l0ltEWw==
X-Google-Smtp-Source: AGHT+IHb2tLJeEj/nhEIcvCueP11HP0tzz903p60s9RvGJF27LFwQlQKr5YD0ey6aPDR1IvAD0AJ740K8RZlJQ==
X-Received: from wmbbh20.prod.google.com ([2002:a05:600c:3d14:b0:434:fd4d:ffad])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3c85:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-436e2679a7cmr125832515e9.5.1736534484149;
 Fri, 10 Jan 2025 10:41:24 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:43 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-17-8419288bc805@google.com>
Subject: [PATCH RFC v2 17/29] mm: asi: Map vmalloc/vmap data as nonsensitive
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

We add new VM flags for sensitive and global-nonsensitive, parallel to
the corresponding GFP flags.

__get_vm_area_node and friends will default to creating
global-nonsensitive VM areas, and vmap then calls asi_map as necessary.

__vmalloc_node_range has additional logic to check and set defaults for
the sensitivity of the underlying page allocation. It does this via an
initial __set_asi_flags call - note that it then calls
__get_vm_area_node which also calls __set_asi_flags. This second call
is a NOP.

By default, we mark the underlying page allocation as sensitive, even
if the VM area is global-nonsensitive. This is just an optimization to
avoid unnecessary asi_map etc, since presumably most code has no reason
to access vmalloc'd data through the direct map.

There are some details of the GFP-flag/VM-flag interaction that are not
really obvious, for example: what should happen when callers of
__vmalloc explicitly set GFP sensitivity flags? (That function has no VM
flags argument). For the moment let's just not block on that and focus
on adding the infrastructure, though.

At the moment, the high-level vmalloc APIs doesn't actually provide a
way to configure sensitivity, this commit just adds the infrastructure.
We'll have to decide how to expose this to allocation sites as we
implement more denylist logic. vmap does already allow configuring vm
flags.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/vmalloc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8d260f2174fe664b54dcda054cb9759ae282bf03..00745edf0b2c5f4c769a46bdcf0872223de5299d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3210,6 +3210,7 @@ struct vm_struct *remove_vm_area(const void *addr)
 {
 	struct vmap_area *va;
 	struct vm_struct *vm;
+	unsigned long vm_addr;
 
 	might_sleep();
 
@@ -3221,6 +3222,7 @@ struct vm_struct *remove_vm_area(const void *addr)
 	if (!va || !va->vm)
 		return NULL;
 	vm = va->vm;
+	vm_addr = (unsigned long) READ_ONCE(vm->addr);
 
 	debug_check_no_locks_freed(vm->addr, get_vm_area_size(vm));
 	debug_check_no_obj_freed(vm->addr, get_vm_area_size(vm));
@@ -3352,6 +3354,7 @@ void vfree(const void *addr)
 				addr);
 		return;
 	}
+	asi_unmap(ASI_GLOBAL_NONSENSITIVE, vm->addr, get_vm_area_size(vm));
 
 	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
 		vm_reset_perms(vm);
@@ -3397,6 +3400,7 @@ void vunmap(const void *addr)
 				addr);
 		return;
 	}
+	asi_unmap(ASI_GLOBAL_NONSENSITIVE, vm->addr, get_vm_area_size(vm));
 	kfree(vm);
 }
 EXPORT_SYMBOL(vunmap);
@@ -3445,16 +3449,21 @@ void *vmap(struct page **pages, unsigned int count,
 
 	addr = (unsigned long)area->addr;
 	if (vmap_pages_range(addr, addr + size, pgprot_nx(prot),
-				pages, PAGE_SHIFT) < 0) {
-		vunmap(area->addr);
-		return NULL;
-	}
+				pages, PAGE_SHIFT) < 0)
+		goto err;
+
+	if (asi_map(ASI_GLOBAL_NONSENSITIVE, area->addr,
+		    get_vm_area_size(area)))
+		goto err; /* The necessary asi_unmap() is in vunmap. */
 
 	if (flags & VM_MAP_PUT_PAGES) {
 		area->pages = pages;
 		area->nr_pages = count;
 	}
 	return area->addr;
+err:
+	vunmap(area->addr);
+	return NULL;
 }
 EXPORT_SYMBOL(vmap);
 
@@ -3711,6 +3720,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		goto fail;
 	}
 
+	if (asi_map(ASI_GLOBAL_NONSENSITIVE, area->addr,
+		    get_vm_area_size(area)))
+		goto fail; /* The necessary asi_unmap() is in vfree. */
+
 	return area->addr;
 
 fail:

-- 
2.47.1.613.gc27f4b7a9f-goog


