Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3CC3B7A81
	for <lists+linux-efi@lfdr.de>; Wed, 30 Jun 2021 00:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhF2Wvc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Jun 2021 18:51:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40918 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbhF2Wvc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Jun 2021 18:51:32 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 205A71FDDA;
        Tue, 29 Jun 2021 22:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625006943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlvM3MzcnkI5ct41kravAhdLb8Av6htcPQ3tAc07kmY=;
        b=ljGaQc3VJLB2w+oNaBigYEtTsLD44cQcnKzJcpRXjVEBNZYFQSo/UD03tJuQGjVqDjAOBQ
        VHiNzEz6QQwlFfyXQ7s6A0OkuLHup9KzDOeeNKE27lXp8Fep8m1fB0Ys3wMiOejDGjpD2D
        KTLlDkhxxtN/Yg2ggdLNeeie7zj8HX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625006943;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlvM3MzcnkI5ct41kravAhdLb8Av6htcPQ3tAc07kmY=;
        b=/GpuesW/GrvcNHBpUkzkoLxs+SajReBCJCfO3O7+/BZJa3Bwcz2CTrNQI3Am/kHASYejbk
        jhE3+mC7JwujOVBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 0DD2C11906;
        Tue, 29 Jun 2021 22:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625006943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlvM3MzcnkI5ct41kravAhdLb8Av6htcPQ3tAc07kmY=;
        b=ljGaQc3VJLB2w+oNaBigYEtTsLD44cQcnKzJcpRXjVEBNZYFQSo/UD03tJuQGjVqDjAOBQ
        VHiNzEz6QQwlFfyXQ7s6A0OkuLHup9KzDOeeNKE27lXp8Fep8m1fB0Ys3wMiOejDGjpD2D
        KTLlDkhxxtN/Yg2ggdLNeeie7zj8HX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625006943;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlvM3MzcnkI5ct41kravAhdLb8Av6htcPQ3tAc07kmY=;
        b=/GpuesW/GrvcNHBpUkzkoLxs+SajReBCJCfO3O7+/BZJa3Bwcz2CTrNQI3Am/kHASYejbk
        jhE3+mC7JwujOVBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 47eGA1+j22A8XgAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 29 Jun 2021 22:49:03 +0000
Date:   Wed, 30 Jun 2021 00:48:48 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] virt: Add sev_secret module to expose
 confidential computing secrets
Message-ID: <YNujUGuIpMc8VJPS@zn.tnic>
References: <20210628183431.953934-1-dovmurik@linux.ibm.com>
 <20210628183431.953934-4-dovmurik@linux.ibm.com>
 <YNojYBIwk0xCHQ0v@zn.tnic>
 <6e35f6db-9c5b-3c75-a66b-de1392295f6a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e35f6db-9c5b-3c75-a66b-de1392295f6a@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 29, 2021 at 10:23:49AM +0300, Dov Murik wrote:
> But not if it's a generic driver that is useful for other confidential
> computing implementations.  Consider some non-encrypting guest memory
> isolation mechanism where the host can't read most guest pages; this
> module might be useful there too.

Anything concrete or just hypothetical?

In any case, if this thing is generic, it should not have "AMD" and
"SEV" in the strings.

> Also, isn't it a bit weird to depend on CONFIG_AMD_MEM_ENCRYPT but not
> use any of its APIs?

Yeah, see above.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
