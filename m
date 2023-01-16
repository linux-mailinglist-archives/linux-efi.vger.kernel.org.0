Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1B566D0E3
	for <lists+linux-efi@lfdr.de>; Mon, 16 Jan 2023 22:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjAPVWq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Jan 2023 16:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjAPVWq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Jan 2023 16:22:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F3F22031;
        Mon, 16 Jan 2023 13:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673904165; x=1705440165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SuTGGIHQH37aq7t2M/pxLpldt78SXV6xIw0m542+wJ4=;
  b=LWL1IavCrg/tKPTqhBmrg87OYmZbiCzDiJ14+/rYHLnv6WfFl9aDsuMZ
   /3w8ebr8gj7GfCQGIFxPS1B7exgCh+GHLZKql4a2Ql1PR0oz5Hpbt7Ta7
   YtPlsgVv+x+rCtAYYlp3M7L4xreswN3MhmgHOlr+7Lo1fzZQgJY+8regQ
   WAAyyOd1vyuDWsjouwe2Din6cLwSPywxUGEjkC9SHrEMPc4AANP6RxJkx
   /sEvFjYs0agjkUwJg7PGqX9u3KPwL8AVobXglUo9xxbBce7n+mh3r/2sw
   BBrha1bCRemhwcUWka1fymQkMCLnh9a38CjvLK5L3Lycua9RwFtYCi5vI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="304244491"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="304244491"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 13:22:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="904433033"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="904433033"
Received: from paichuan-mobl1.amr.corp.intel.com (HELO [10.209.71.173]) ([10.209.71.173])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 13:22:44 -0800
Message-ID: <def9b0b5-b880-be99-fa95-b05d76a91824@intel.com>
Date:   Mon, 16 Jan 2023 13:22:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
Content-Language: en-US
To:     Gerd Hoffmann <kraxel@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name>
 <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/16/23 02:56, Gerd Hoffmann wrote:
>> And we add this protocol to address very temporary problem: once
>> unaccepted memory support get upstream it is just a dead weight.
> Maybe, maybe not.  unaccepted memory support has a Kconfig switch after
> all.  If we figure in 3-5 years that all distros have enabled it anyway
> we can drop it again.  For the transition period it will surely be
> useful.

I agree with Kirill here.

Having unaccepted memory *AND* this firmware-driven feature really is
just implementing the same thing twice.

I'd much rather have the Kconfig option forced on for all guests that
*might* need unaccepted memory support than carry redundant implementations.

Also, _if_ we allow folks to turn the Kconfig off and get access to all
their memory, they might get used to that.  Removing this firmware
interface from the kernel in a few years could be viewed as a
regression.  Then, we'll be stuck with this forever.

In any case, the firmware side of things didn't seem like _that_ much
code.  So, I'm not protesting *that* strongly.  But, I also don't
believe for a second that this is going to be removed in 3-5 years.
