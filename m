Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ECD501AA0
	for <lists+linux-efi@lfdr.de>; Thu, 14 Apr 2022 19:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbiDNSCA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Apr 2022 14:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243465AbiDNSB7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Apr 2022 14:01:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A0BBC87;
        Thu, 14 Apr 2022 10:59:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D3FFD1F74A;
        Thu, 14 Apr 2022 17:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649959171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=iOwerLt2xkw4bR3mFy/maLe3ZNe3PCPZ0yj28asR8ck=;
        b=dXN73kAPjwVJCJEGguwlif2M78TYrzjjppHjSdJLIU1DRNsVZBnM7rvUXRkVorIKUCtRJ4
        Wu3qOGmQDT3XnbopejO26Y6A1nWYEH9PWI0gM/rhvivN23h4K5BlCwosH+ba9F5De7bH57
        KWoQ8mFRe53ubWKgDBzrjHxW1kWsEO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649959171;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=iOwerLt2xkw4bR3mFy/maLe3ZNe3PCPZ0yj28asR8ck=;
        b=NFPCZjIo1ywXX3HsTYg30RAfOJFvBox2SnC9uTa43hl8vb27bvXQrQ8I6Jfii6kx89YHb1
        TpbPeWdgw9ilT9Aw==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BA700A3B89;
        Thu, 14 Apr 2022 17:59:31 +0000 (UTC)
Date:   Thu, 14 Apr 2022 19:59:30 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: How to list keys used for kexec
Message-ID: <20220414175930.GM163591@kunlun.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello,

apparently modules are verified by keys from 'secondary' keyring on all
platforms.

If you happen to know that it's this particular keyring, and know how
to list keyrings recursively you can find the keys that are used for
verifying modules.

However, for kexec we have

 - primary keyring on aarch64
 - platform keyring on s390
 - secondary AND platform keyring on x86

How is a user supposed to know which keys are used for kexec image
verification?

There is an implicit keyring that is ad-hoc constructed by the code that
does the kexec verification but there is no key list observable from
userspace that corresponds to this ad-hoc keyring only known to the kexec
code.

Can the kernel make the information which keys are used for what purpose
available to the user?

Thanks

Michal

