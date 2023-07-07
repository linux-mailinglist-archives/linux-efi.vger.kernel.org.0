Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A599B74AD3D
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 10:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjGGImJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jul 2023 04:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGGImI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jul 2023 04:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A58A90
        for <linux-efi@vger.kernel.org>; Fri,  7 Jul 2023 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688719281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBR9f0r6qj9T/laRL93krURZPm3hZ8Dm5t8S9yrOV30=;
        b=guh836LVRBV892RfpPEo+eqLrf/By4P0jUIQL+D5iXTxY1TxpST4bd+tBp12MHJTzGRHg4
        ACP2UVxVV8JeNYkxK0CzvpZbp6dXYZCA/cSizHIYE0dsADjajQnDa6jxFGf11AuKWaYd3K
        OPZhAsr3MJG7Ookt959+Mq+SLZzsPVM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-mseXw9BVPAa9SLtaA0G1vQ-1; Fri, 07 Jul 2023 04:41:17 -0400
X-MC-Unique: mseXw9BVPAa9SLtaA0G1vQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2C5680027F;
        Fri,  7 Jul 2023 08:41:16 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4DE1200B402;
        Fri,  7 Jul 2023 08:41:15 +0000 (UTC)
Date:   Fri, 7 Jul 2023 16:41:12 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Tao Liu <ltao@redhat.com>, thomas.lendacky@amd.com,
        Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, michael.roth@amd.com
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <ZKfPqK+lqK6zly2w@MiWiFi-R3L-srv>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
 <ZKfLYG_4DANc_i5r@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKfLYG_4DANc_i5r@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 07/07/23 at 10:22am, Joerg Roedel wrote:
> On Fri, Jul 07, 2023 at 12:23:59PM +0800, Baoquan He wrote:
> > I am wondering why we don't detect the cpu type and return early inside
> > sev_enable() if it's Intel cpu.
> > 
> > We can't rely on CONFIG_AMD_MEM_ENCRYPT to decide if the code need be
> > executed or not because we usually enable them all in distros.
> 
> Looking at the code in head_64.S, by the time sev_enable() runs the SEV
> bit should already be set in sev_status. Maybe use that to detect
> whether SEV is enabled and bail out early?

Makes sense to me. Thanks.

