Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F081E74A9E7
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 06:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGGEZJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jul 2023 00:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGGEZE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jul 2023 00:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F4E6E
        for <linux-efi@vger.kernel.org>; Thu,  6 Jul 2023 21:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688703854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WH5e5yrUwYhfZlLQss/cQIH00cXYe+Ubohm+t4WsCng=;
        b=fku4POBv3pjzdZ24TEi2/vYCNhDmSTaoRK/UCAX3O6KWPjDoMZ5UfO0QT7RLWuV9scem00
        bY2LuHM+oaGsQb52QsrRKYCPBHOtcQ5kekr+uHncN/oaIO+g2RxzJgg8kAVaFNlUkE6gsF
        7g0ybQBbyZzrLWSIhiPhJrST8D5wMLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-9SxUlnh6OMaN0meM_RXW8g-1; Fri, 07 Jul 2023 00:24:06 -0400
X-MC-Unique: 9SxUlnh6OMaN0meM_RXW8g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F2B580123E;
        Fri,  7 Jul 2023 04:24:06 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98DE7492C13;
        Fri,  7 Jul 2023 04:24:03 +0000 (UTC)
Date:   Fri, 7 Jul 2023 12:23:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Tao Liu <ltao@redhat.com>, jroedel@suse.de, thomas.lendacky@amd.com
Cc:     Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, michael.roth@amd.com
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 07/07/23 at 11:38am, Tao Liu wrote:
> Hi Borislav,
> 
> Thanks for the patch review!
> 
> On Thu, Jul 6, 2023 at 1:34 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Thu, Jun 01, 2023 at 03:20:44PM +0800, Tao Liu wrote:
> > > A kexec kernel bootup hang is observed on Intel Atom cpu due to unmapped
> >
> > s/cpu/CPU/g
> >
> > > EFI config table.
> > >
> > > Currently EFI system table is identity-mapped for the kexec kernel, but EFI
> > > config table is not mapped explicitly:
> >
> > Why does the EFI config table *need* to be mapped explicitly?
> >
> > >     commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI
> > >                           tables to the ident map")
> > >
> > > Later in the following 2 commits, EFI config table will be accessed when
> > > enabling sev at kernel startup.
> >
> > What does SEV have to do with an Intel problem?
> 
> For the 2 questions above. The call stack is follows:
> 
> head_64.S:.Lon_kernel_cs(which is before extract_kernel) -> sev_enable
> -> snp_init -> find_cc_blob -> find_cc_blob_efi. No matter what cpu,
> with CONFIG_AMD_MEM_ENCRYPT enabled, all will enter sev_enable() and
> go through these functions. I assume it is harmless for Intel cpu,

I am wondering why we don't detect the cpu type and return early inside
sev_enable() if it's Intel cpu.

We can't rely on CONFIG_AMD_MEM_ENCRYPT to decide if the code need be
executed or not because we usually enable them all in distros.

Thanks
Baoquan

