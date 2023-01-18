Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D9671646
	for <lists+linux-efi@lfdr.de>; Wed, 18 Jan 2023 09:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjARI2f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Jan 2023 03:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjARI0o (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Jan 2023 03:26:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B153748A18
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 23:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674028309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGNzJ+IktHZmNqaFlDrMhWkTURpf/0hrykEij67avpU=;
        b=PiSsPPx/fdA4akySfN6dDlkX08/tYD14dvdkbnE/FoUHotX80e43AafvBjhp0ucXxeJo60
        zVOkp4kGuOgL3PZrsR3Vhn6W/GD1W7/KWvnvmgyWC/iiE4jYUn38Swtb3QNRofn6JVK9Gn
        B0worTx/JxsLxuE8I9phtKnesqJadiU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-Wibq0QIGMcKNIpc03dw2JQ-1; Wed, 18 Jan 2023 02:51:43 -0500
X-MC-Unique: Wibq0QIGMcKNIpc03dw2JQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 041CE38041C0;
        Wed, 18 Jan 2023 07:51:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97CF039D92;
        Wed, 18 Jan 2023 07:51:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 025421800091; Wed, 18 Jan 2023 08:51:40 +0100 (CET)
Date:   Wed, 18 Jan 2023 08:51:40 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     devel@edk2.groups.io, dionnaglaze@google.com
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [edk2-devel] [PATCH v2] x86/efi: Safely enable unaccepted memory
 in UEFI
Message-ID: <20230118075140.6pyszln4ovi2htxk@sirius.home.kraxel.org>
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name>
 <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
 <20230116123057.wvr6rz7y3ubgcm5z@box.shutemov.name>
 <CAMj1kXGVNHqGN2uhziARu9H3RQiqbPJBE1GxHuWzC5gajJyaeA@mail.gmail.com>
 <20230116134246.soworigs56bz5v7o@box.shutemov.name>
 <CAAH4kHb6-6QkMnYbcQ6MyMkwSBUN-Q3CcM3fuiStdbbnSfJv1A@mail.gmail.com>
 <20230116231711.cudsnxvnfg6aef3w@box.shutemov.name>
 <CAAH4kHbhSfeDeBCLCO4Bc2MK8Ds-kjXxCnrkMEP1j_GO5sh18w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH4kHbhSfeDeBCLCO4Bc2MK8Ds-kjXxCnrkMEP1j_GO5sh18w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

  Hi,

> To Gerd's point, removing "first in edk2, later in linux too" I think
> is backwards. We need all users of the protocol to agree that SEV-SNP
> and TDX strictly imply unaccepted memory support. Only then can we
> remove the protocol from EDK2.

Its not backwards.

edk2 dropping support first would result in break kernels without
support for unaccepted memory.  Which is why we wait until such
kernels are EOL.

Linux dropping support first would result in firmware accepting all
memory again.  So that isn't a good plan.  Thats why linux should
support the protocol a bit longer, while firmware versions which
expect negotiation happening are still in use.

take care,
  Gerd

