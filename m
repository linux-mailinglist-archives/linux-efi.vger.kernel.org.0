Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0379812DE0C
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jan 2020 08:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgAAHXC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jan 2020 02:23:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33229 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725783AbgAAHXC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jan 2020 02:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577863381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkJ1mIbTrrBOlKZUoQPdf32Q2bHvXxd3EaQrbVcK/wk=;
        b=HMTmPSu5gdMK/K5C9ATTLOARBM7Og2aKuM3vrOVm4lws9KzxwNXrCm+0EM855oDzxcM1bE
        2pgRk2E6BRZrKuOU0n0kbBo7Iq3fwu/vHy+8N559a3j4VY/HL+2T/2COpK9I4hC3RSvObk
        KLYhgOqWqaGGd+HSDwtdD0YWboNEE7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-FPJNVcs3Ocm2QR97esNbTQ-1; Wed, 01 Jan 2020 01:20:58 -0500
X-MC-Unique: FPJNVcs3Ocm2QR97esNbTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36F75185432D;
        Wed,  1 Jan 2020 06:20:56 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BE2A5D9E2;
        Wed,  1 Jan 2020 06:20:51 +0000 (UTC)
Date:   Wed, 1 Jan 2020 14:20:47 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, kexec@lists.infradead.org,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH v2 4/4] efi: Fix handling of multiple efi_fake_mem=
 entries
Message-ID: <20200101062047.GA16393@dhcp-128-65.nay.redhat.com>
References: <157782985777.367056.14741265874314204783.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157782987865.367056.15199592105978588123.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200101045141.GA15155@dhcp-128-65.nay.redhat.com>
 <CAPcyv4hSB9B5tiKVwtNOgDS6KS2Pj6f962OPBZVZpPjrBt6Z8A@mail.gmail.com>
 <20200101061505.GA15717@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101061505.GA15717@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> > Does kexec preserve iomem? I.e. as long as the initial translation of
> > efi entries to e820, and resulting resource tree, is preserved by
> > successive kexec cycles then I think we're ok.
> 
> It will not preserve them automatically, but that can be fixed if
> needed.
> 
> There are two places:
> 1. the in kernel loader, we can do similar with below commit (for Soft
> Reseved instead):
> commit 980621daf368f2b9aa69c7ea01baa654edb7577b
> Author: Lianbo Jiang <lijiang@redhat.com>
> Date:   Tue Apr 23 09:30:07 2019 +0800
> 
>     x86/crash: Add e820 reserved ranges to kdump kernel's e820 table

Oops, that is for kdump only, for kexec, should update the kexec e820
table.  But before doing that we need first to see if this is necessary. 

Thanks
Dave

