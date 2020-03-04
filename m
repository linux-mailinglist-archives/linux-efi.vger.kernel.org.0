Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B166C179475
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 17:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgCDQG2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 11:06:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40883 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726694AbgCDQG1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 11:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583337986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUY8udRQNo9T1W7t0z9MO6yA071FZ3UK1//rz1amElo=;
        b=e+RQjjXFfegze7z9/tEB4xD0dqA2zBkqDIPlAtHC3Uj7kEF5QvdXqjkyodvMtDM99O97bF
        5fRltM7L53RA9hbMgcN0h3t1Lr+PjhwwExgZmUUJMwah1Bkxz3aHbn+9owqNqeZ4OpYldb
        vY6e6KudXzJay2iIjKNIvx0ywc/cjpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-356PBLg5PkKYaRA0mLPPDw-1; Wed, 04 Mar 2020 11:06:22 -0500
X-MC-Unique: 356PBLg5PkKYaRA0mLPPDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C8C6DBA6;
        Wed,  4 Mar 2020 16:06:21 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 712E38B56A;
        Wed,  4 Mar 2020 16:06:21 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 60B6586A01;
        Wed,  4 Mar 2020 16:06:21 +0000 (UTC)
Date:   Wed, 4 Mar 2020 11:06:21 -0500 (EST)
From:   Vladis Dronov <vdronov@redhat.com>
To:     joeyli <jlee@suse.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <701521302.13078565.1583337981352.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200304140720.GQ16878@linux-l9pv.suse>
References: <20200303085528.27658-1-vdronov@redhat.com> <20200304140720.GQ16878@linux-l9pv.suse>
Subject: Re: [PATCH] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.204.205, 10.4.195.15]
Thread-Topic: fix a race and a buffer overflow while reading efivars via sysfs
Thread-Index: IH2nruIWMwx9vxI4ZbXE47kW8jiXfg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello, Joey, all,

Let me address both of your emails here.

> Looks that kernel uses EFI protocol to query variable everytime, then
> why should kernel keeps a copy of variable data size, data and attributes in
> memory? It makes sense to keep VariableName and VendorGuid, but why data?
> 
> The efi_variable can be used to interactive with userland. But we do not
> need to keep a data copy in efi_variable with efivar_entry. e.g. The
> efivarfs_file_read() allocates a buffer for reading variable instead
> of using efi_variable->Data.

Indeed, as far as I understand the code, we keep var's data in a memory. I
cannot tell why such was done when this code was written. Given that this
code is considered "old" and may even be obsoleted, I wouldn't like to start
a deep rewrite, and only focus on fixing bugs, like the one mentioned.

> I have reviewed and tested this patch. It's good to me if we still want
> to use efi_variable structure as the return buffer of UEFI get/set_variable
> protocols.
> 
> Please feel free to add:
> Reviewed-by: Joey Lee <jlee@suse.com>

Thank you for your time on the review! Much appreciated. Still, I've just
sent out a v2 patch (with you in To:) which is indeed simpler and implements
and idea Ard suggested, and fixes only the exact bug mentioned. I'm not sure
which one will be accepted (if any), could you please, to look at v2 also?

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

