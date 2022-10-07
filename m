Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD2E5F7D2E
	for <lists+linux-efi@lfdr.de>; Fri,  7 Oct 2022 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJGSMM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Oct 2022 14:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiJGSMK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Oct 2022 14:12:10 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31B0B84F;
        Fri,  7 Oct 2022 11:12:09 -0700 (PDT)
Message-ID: <4f9f3ed4-1081-9204-699e-2c3b4339cc37@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665166328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kWdnwYkTd314suzWEm5V6fMUcQCg+9f/rEN9PQvpg0M=;
        b=ochD1DywPILefyk5msmvRZoRwcp8bfWKI/22U/0BxJJoRzpz7DJQ941O1/hWDNUijGHikM
        QUh4O8WVBX3YH904o7GAKq2QAv7kvkUulQtR/ik0kWv1KqZIuJTQGrGM7nlFsdsTMNtyh5
        5/Zht6Bijgro4nW65gpZreas03XBSnQ=
Date:   Fri, 7 Oct 2022 12:12:02 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3 RESEND] block: sed-opal: Implement
 IOC_OPAL_REVERT_LSP
Content-Language: en-US
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@linux.vnet.ibm.com,
        msuchanek@suse.de, mpe@ellerman.id.au, nayna@linux.ibm.com,
        axboe@kernel.dk, akpm@linux-foundation.org,
        linux-efi@vger.kernel.org, keyrings@vger.kernel.org
References: <20220818143045.680972-1-gjoyce@linux.vnet.ibm.com>
 <20220818143045.680972-3-gjoyce@linux.vnet.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220818143045.680972-3-gjoyce@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>

On 8/18/2022 8:30 AM, gjoyce@linux.vnet.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> 
> This is used in conjunction with IOC_OPAL_REVERT_TPR to return a drive to
> Original Factory State without erasing the data. If IOC_OPAL_REVERT_LSP
> is called with opal_revert_lsp.options bit OPAL_PRESERVE set prior
> to calling IOC_OPAL_REVERT_TPR, the drive global locking range will not
> be erased.
> 
> Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> ---
>  block/opal_proto.h            |  4 ++++
>  block/sed-opal.c              | 40 +++++++++++++++++++++++++++++++++++
>  include/linux/sed-opal.h      |  1 +
>  include/uapi/linux/sed-opal.h | 11 ++++++++++
>  4 files changed, 56 insertions(+)
> 
> diff --git a/block/opal_proto.h b/block/opal_proto.h
> index b486b3ec7dc4..6127c08267f8 100644
> --- a/block/opal_proto.h
> +++ b/block/opal_proto.h
> @@ -210,6 +210,10 @@ enum opal_parameter {
>  	OPAL_SUM_SET_LIST = 0x060000,
>  };
>  
> +enum opal_revertlsp {
> +	OPAL_KEEP_GLOBAL_RANGE_KEY = 0x060000,
> +};
> +
>  /* Packets derived from:
>   * TCG_Storage_Architecture_Core_Spec_v2.01_r1.00
>   * Secion: 3.2.3 ComPackets, Packets & Subpackets
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index e4d8fbdc9dad..2916b9539b84 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -1593,6 +1593,26 @@ static int internal_activate_user(struct opal_dev *dev, void *data)
>  	return finalize_and_send(dev, parse_and_check_status);
>  }
>  
> +static int revert_lsp(struct opal_dev *dev, void *data)
> +{
> +	struct opal_revert_lsp *rev = data;
> +	int err;
> +
> +	err = cmd_start(dev, opaluid[OPAL_THISSP_UID],
> +			opalmethod[OPAL_REVERTSP]);
> +	add_token_u8(&err, dev, OPAL_STARTNAME);
> +	add_token_u64(&err, dev, OPAL_KEEP_GLOBAL_RANGE_KEY);
> +	add_token_u8(&err, dev, (rev->options & OPAL_PRESERVE) ?
> +			OPAL_TRUE : OPAL_FALSE);
> +	add_token_u8(&err, dev, OPAL_ENDNAME);
> +	if (err) {
> +		pr_debug("Error building REVERT SP command.\n");
> +		return err;
> +	}
> +
> +	return finalize_and_send(dev, parse_and_check_status);
> +}
> +
>  static int erase_locking_range(struct opal_dev *dev, void *data)
>  {
>  	struct opal_session_info *session = data;
> @@ -2208,6 +2228,23 @@ static int opal_get_discv(struct opal_dev *dev, struct opal_discovery *discv)
>  	return discv->size; /* modified to actual length of data */
>  }
>  
> +static int opal_revertlsp(struct opal_dev *dev, struct opal_revert_lsp *rev)
> +{
> +	/* controller will terminate session */
> +	const struct opal_step steps[] = {
> +		{ start_admin1LSP_opal_session, &rev->key },
> +		{ revert_lsp, rev }
> +	};
> +	int ret;
> +
> +	mutex_lock(&dev->dev_lock);
> +	setup_opal_dev(dev);
> +	ret = execute_steps(dev, steps, ARRAY_SIZE(steps));
> +	mutex_unlock(&dev->dev_lock);
> +
> +	return ret;
> +}
> +
>  static int opal_erase_locking_range(struct opal_dev *dev,
>  				    struct opal_session_info *opal_session)
>  {
> @@ -2714,6 +2751,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
>  	case IOC_OPAL_GENERIC_TABLE_RW:
>  		ret = opal_generic_read_write_table(dev, p);
>  		break;
> +	case IOC_OPAL_REVERT_LSP:
> +		ret = opal_revertlsp(dev, p);
> +		break;
>  	case IOC_OPAL_DISCOVERY:
>  		ret = opal_get_discv(dev, p);
>  		break;
> diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> index 9197b7a628f2..3a6082ff97e7 100644
> --- a/include/linux/sed-opal.h
> +++ b/include/linux/sed-opal.h
> @@ -43,6 +43,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
>  	case IOC_OPAL_MBR_DONE:
>  	case IOC_OPAL_WRITE_SHADOW_MBR:
>  	case IOC_OPAL_GENERIC_TABLE_RW:
> +	case IOC_OPAL_REVERT_LSP:
>  	case IOC_OPAL_DISCOVERY:
>  		return true;
>  	}
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> index 89dd108b426f..bc91987a6328 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -51,6 +51,10 @@ struct opal_key {
>  	__u8 key[OPAL_KEY_MAX];
>  };
>  
> +enum opal_revert_lsp_opts {
> +	OPAL_PRESERVE = 0x01,
> +};
> +
>  struct opal_lr_act {
>  	struct opal_key key;
>  	__u32 sum;
> @@ -137,6 +141,12 @@ struct opal_discovery {
>  	__u64 size;
>  };
>  
> +struct opal_revert_lsp {
> +	struct opal_key key;
> +	__u32 options;
> +	__u32 __pad;
> +};
> +
>  #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
>  #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
>  #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
> @@ -154,5 +164,6 @@ struct opal_discovery {
>  #define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 234, struct opal_shadow_mbr)
>  #define IOC_OPAL_GENERIC_TABLE_RW   _IOW('p', 235, struct opal_read_write_table)
>  #define IOC_OPAL_DISCOVERY          _IOW('p', 236, struct opal_discovery)
> +#define IOC_OPAL_REVERT_LSP         _IOW('p', 237, struct opal_revert_lsp)
>  
>  #endif /* _UAPI_SED_OPAL_H */
